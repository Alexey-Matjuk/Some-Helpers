//
//  Constraints.swift
//  Reisebank
//
//  Created by Alexey Matjuk on 3/7/17.
//
//

import UIKit

public typealias LayoutConstraint = NSLayoutConstraint
public typealias LayoutAttribute = NSLayoutAttribute
public typealias LayoutRelation = NSLayoutRelation
public typealias LayoutPriority = UILayoutPriority

public extension LayoutConstraint {
    
    public convenience init(item view1: UIView, attribute: LayoutAttribute, toItem view2: UIView? = nil, relatedBy relation: LayoutRelation = .equal, constant: CGFloat = 0, priority: LayoutPriority = UILayoutPriority.required) {
        self.init(item: view1, attribute: attribute, relatedBy: relation, toItem: view2, attribute: (view2 != nil ? attribute : .notAnAttribute), multiplier: 1, constant: constant)
        self.priority = priority
    }

    public static func constraints(forItem view1: UIView, attributes: [LayoutAttribute], toItem view2: UIView? = nil, relatedBy relation: LayoutRelation = .equal, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> [LayoutConstraint] {
        return attributes.map {
            LayoutConstraint(item: view1, attribute: $0, toItem: view2, relatedBy: relation, constant: constant, priority: priority)
        }
    }

    public convenience init(item view1: UIView, toItem view2: UIView?, verticalSpacing spacing: CGFloat) {
        self.init(item: view1, attribute: .top, relatedBy: .equal, toItem: view2, attribute: .bottom, multiplier: 1, constant: spacing)
    }
    
    public convenience init(item view1: UIView, toItem view2: UIView?, horizontalSpacing spacing: CGFloat) {
        self.init(item: view1, attribute: .trailing, relatedBy: .equal, toItem: view2, attribute: .leading, multiplier: 1, constant: -spacing)
    }
    
}
