//
//  UIScrollView+Extensions.swift
//  Reisebank
//
//  Created by Vova Tanakov on 4/4/17.
//
//

extension UIScrollView {
    
    public func scrollToTop() {
        scrollRectToVisible(CGRect(origin: CGPoint(x: 0, y: -contentInset.top), size: .zero), animated: true)
    }
    
}
