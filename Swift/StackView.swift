//
//  StackView.swift
//  Reisebank
//
//  Created by Alexey Matjuk on 3/7/17.
//
//

@IBDesignable
open class StackView: UIView {
    
    public enum LayoutConstraintAxis {
        case horizontal, vertical
    }
    
    public enum StackViewAlignment {
        
        case fill, leading, center, trailing
        
        public static var bottom: StackViewAlignment { return .trailing }
        public static var top: StackViewAlignment { return .leading }
        
    }
    
    public enum StackViewDistribution {
        case fill, fillEqually
    }
    
    // MARK: Inspectable Properties
    
    @IBInspectable
    internal var usesVerticalLayout: Bool {
        get { return axis == .vertical }
        set { axis = newValue ? .vertical : .horizontal }
    }
    
    @IBInspectable
    open var spacing: CGFloat = 0 {
        didSet {
            spacingConstraints.forEach { $0.constant = spacing }
        }
    }
    
    // MARK: Properties
    
    override open var backgroundColor: UIColor? {
        get { return .clear }
        set { super.backgroundColor = .clear }
    }
    
    open var axis: LayoutConstraintAxis = .vertical {
        didSet {
            setNeedsUpdateConstraints()
        }
    }
    
    open var distribution: StackViewDistribution = .fill {
        didSet {
            setNeedsUpdateConstraints()
        }
    }
    
    open var alignment: StackViewAlignment = .fill {
        didSet {
            setNeedsUpdateConstraints()
        }
    }
    
    // MARK: Constraints
    
    private var arrangedConstraints = [LayoutConstraint]()
    private var spacingConstraints = [LayoutConstraint]()
    
    open override func updateConstraints() {
        removeConstraints(arrangedConstraints)
        arrangedConstraints.removeAll()
        spacingConstraints.removeAll()
        
        arrangedConstraints.append(
            LayoutConstraint(
                item: self,
                attribute: usesVerticalLayout ? .width : .height,
                priority: UILayoutPriority(rawValue: UILayoutPriority.fittingSizeLevel.rawValue + 1)
            )
        )
        
        var previousView: UIView?
        
        let leadingAttribute: LayoutAttribute = usesVerticalLayout ? .leading : .top
        let trailingAttribute: LayoutAttribute = usesVerticalLayout ? .trailing : .bottom
        let centerAttribute: LayoutAttribute = usesVerticalLayout ? .centerX : .centerY
        
        for view in subviews {
            guard !view.isHidden else { continue }
            
            let leadingRelation: LayoutRelation
            let trailingRelation: LayoutRelation
            
            switch alignment {
            case .fill:
                leadingRelation = .equal
                trailingRelation = .equal
            case .leading:
                leadingRelation = .equal
                trailingRelation = .greaterThanOrEqual
            case .trailing:
                leadingRelation = .greaterThanOrEqual
                trailingRelation = .equal
            case .center:
                leadingRelation = .greaterThanOrEqual
                trailingRelation = .greaterThanOrEqual
                arrangedConstraints.append(LayoutConstraint(item: view, attribute: centerAttribute, toItem: self))
            }
            
            arrangedConstraints.append(LayoutConstraint(item: view, attribute: leadingAttribute, toItem: self, relatedBy: leadingRelation))
            arrangedConstraints.append(LayoutConstraint(item: self, attribute: trailingAttribute, toItem: view, relatedBy: trailingRelation))
            
            if let previousView = previousView {
                if usesVerticalLayout {
                    spacingConstraints.append(LayoutConstraint(item: view, toItem: previousView, verticalSpacing: spacing))
                } else {
                    spacingConstraints.append(LayoutConstraint(item: previousView, toItem: view, horizontalSpacing: spacing))
                }
                if distribution == .fillEqually {
                    arrangedConstraints.append(LayoutConstraint(item: view,
                                                                attribute: usesVerticalLayout ? .height : .width,
                                                                toItem: previousView))
                }
            }
            
            previousView = view
        }
        
        if  let firstView = subviews.first(where: { !$0.isHidden }) {
            arrangedConstraints.append(LayoutConstraint(item: firstView,
                                                        attribute: usesVerticalLayout ? .top : .leading,
                                                        toItem: self))
        }

        if let lastView = subviews.reversed().first(where: { !$0.isHidden }) {
            arrangedConstraints.append(LayoutConstraint(item: lastView,
                                                        attribute: usesVerticalLayout ? .bottom : .trailing,
                                                        toItem: self))
        }

        arrangedConstraints.append(contentsOf: spacingConstraints)
        
        arrangedConstraints.forEach {
            $0.isActive = true
            addConstraint($0)
        }
        
        super.updateConstraints()
    }
    
    override open func didAddSubview(_ subview: UIView) {
        super.didAddSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        guard superview != nil else { return }
        observeHiddenValue(of: subview)
    }
    
    override open func willRemoveSubview(_ subview: UIView) {
        super.willRemoveSubview(subview)
        guard superview != nil else { return }
        stopObservingHiddenValue(of: subview)
    }
    
    open override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if newSuperview == nil {
            subviews.forEach { self.stopObservingHiddenValue(of: $0) }
        } else {
            subviews.forEach { self.observeHiddenValue(of: $0) }
        }
    }
    
    private static let kvoHiddenKeyPath = "hidden"
    
    fileprivate func observeHiddenValue(of view: UIView) {
        view.addObserver(self, forKeyPath: StackView.kvoHiddenKeyPath, options: [.old, .new], context: nil)
    }
    
    fileprivate func stopObservingHiddenValue(of view: UIView) {
        view.removeObserver(self, forKeyPath: StackView.kvoHiddenKeyPath, context: nil)
    }
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey:Any]?, context: UnsafeMutableRawPointer?) {
        if  keyPath == StackView.kvoHiddenKeyPath,
            let view = object as? UIView, subviews.contains(view),
            let oldValue = change?[.oldKey] as? Bool, let newValue = change?[.newKey] as? Bool,
            oldValue != newValue {
                setNeedsUpdateConstraints()
                setNeedsLayout()
                layoutIfNeeded()
        }
    }
    
    
}
