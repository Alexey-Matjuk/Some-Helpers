//
//  UITableView+Extensions.swift
//  Reisebank
//
//  Created by Uladzislau Herasiuk on 18.11.16.
//
//

import UIKit

public protocol ReusableView: class {}

public extension ReusableView where Self: UIView {
    
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
    
}

extension UITableViewCell: ReusableView {}

extension UITableView {
    
    public func register<T: UITableViewCell>(_ cellClass: T.Type)   {
        register(cellClass, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T?   {
        return dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T
    }
    
}
