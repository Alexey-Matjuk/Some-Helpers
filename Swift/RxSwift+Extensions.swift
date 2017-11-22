//
//  RxSwift+Extension.swift
//  Reisebank
//
//  Created by Uladzislau Herasiuk on 25.11.16.
//
//

import RxSwift
import RxCocoa
import ReisebankKit

extension Variable {
    
    public func twoWayBind(to property: ControlProperty<Element>) -> Disposable {
        let bindToUIDisposable = asObservable().bind(to: property)
        let bindToVariable = property
            .subscribe(
                onNext: { [weak self] in self?.value = $0 },
                onCompleted: { bindToUIDisposable.dispose() }
        )
        return CompositeDisposable(bindToUIDisposable, bindToVariable)
    }

}

extension PublishSubject {

    public func twoWayBind(to property: ControlProperty<Element>) -> Disposable {
        let bindToUIDisposable = bind(to: property)
        let bindToVariable = property
            .subscribe(
                onNext: { [weak self] in self?.onNext($0) },
                onCompleted: { bindToUIDisposable.dispose() }
        )
        return CompositeDisposable(bindToUIDisposable, bindToVariable)
    }
    
}

extension BehaviorSubject {

    public func twoWayBind(to property: ControlProperty<Element>) -> Disposable {
        let bindToUIDisposable = bind(to: property)
        let bindToVariable = property
            .subscribe(
                onNext: { [weak self] in self?.onNext($0) },
                onCompleted: { bindToUIDisposable.dispose() }
        )
        return CompositeDisposable(bindToUIDisposable, bindToVariable)
    }

}

extension ControlProperty {

    public func twoWayBind(to variable: Variable<PropertyType>) -> Disposable {
        let bindToUIDisposable = variable.asObservable().bind(to: self)
        let bindToVariable = self
            .subscribe(onNext: { [weak variable] in
                variable?.value = $0
            }, onCompleted: {
                bindToUIDisposable.dispose()
            })
        return CompositeDisposable(bindToUIDisposable, bindToVariable)
    }
    
}

extension Reactive where Base : UITableView {
    
    public func items<S : Sequence, Cell : UITableViewCell, O : ObservableType>(cellType: Cell.Type) -> (O) -> (@escaping (Int, S.Iterator.Element, Cell) -> ()) -> Disposable where O.E == S {
        return items(cellIdentifier: Cell.defaultReuseIdentifier , cellType: cellType)
    }
    
}

extension Reactive where Base : UIScrollView {

    // Note: taken from https://github.com/liuznsn/RxMoyaPaginationNetworking/blob/95dd9b1f293522cdbf0f3d874be7281f469a1590/RxNetworkModel/UIScrollView%2BRx.swift
    var reachedBottom: Observable<Void> {
        weak var scrollView = self.base
        return contentOffset
            .flatMap { contentOffset -> Observable<Void> in
                guard let scrollView = scrollView else {
                    return Observable.empty()
                }

                let visibleHeight = scrollView.frame.height - scrollView.contentInset.top - scrollView.contentInset.bottom
                let y = contentOffset.y + scrollView.contentInset.top
                let threshold = max(0.0, scrollView.contentSize.height - visibleHeight)
                
                return y >= threshold ? Observable.just(()) : Observable.empty()
        }
    }

}

extension Reactive where Base : UITableView {

    var reachedBottomCell: Observable<Void> {
        weak var tableView = self.base
        return willDisplayCell
            .map {
                guard let tableView = tableView else { return false }
                return (tableView.numberOfRows(inSection: tableView.numberOfSections - 1) - 1 == $0.indexPath.row)
            }
            .filter { $0 }
            .map { _ in }
            .startWith(())
    }

}

extension Disposables {

    public init(disposables: [Disposable?]) {
        self.init(disposables: disposables.flatMap { $0 } )
    }

}

extension ObservableType {

    public func `do`<R>(next: Observable<R>) -> Observable<R> {
        return map { _ -> () in }.concatMap { next }
    }

}

extension Variable: ObservableType {

    public func subscribe<O>(_ observer: O) -> Disposable where O : ObserverType, O.E == E {
        return asObservable().subscribe(observer)
    }

}
