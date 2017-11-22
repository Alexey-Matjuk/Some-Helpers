//
//  UIView+Inflating.swift
//  Reisebank
//
//  Created by Vova Tanakov on 12/9/16.
//
//

public extension UIView {
    
    func load(from bundle: Bundle? = nil) -> UIView? {
        let bundle = bundle ?? Bundle(for: type(of: self))
        return bundle.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView
    }
    
    public func firstSubviewInHierarchy<T: UIView>(ofType type: T.Type) -> T? {
        for subview in subviews {
            guard let view = subview as? T else {
                return subview.firstSubviewInHierarchy(ofType: type)
            }
            return view
        }
        return nil
    }
    
    public func findFirstResponder() -> UIView? {
        if isFirstResponder {
            return self
        }
        
        for view in subviews {
            let subview = view.findFirstResponder()
            if subview != nil {
                return subview
            }
        }
        
        return nil
    }
    
}
