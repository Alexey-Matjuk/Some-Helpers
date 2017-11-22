//
//  UIStoryboardSegue+Extensions.swift
//  Reisebank
//
//  Created by Uladzislau Herasiuk on 18.11.16.
//
//

import UIKit

extension UIStoryboard {
    
    public struct Name: _RawRepresentable, Equatable, Hashable {
        
        public let rawValue: String
        
        public var hashValue: Int { return rawValue.hashValue }
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
        
        public init(_ rawValue: String) {
            self.rawValue = rawValue
        }

    }

    public convenience init(name: Name, bundle storyboardBundleOrNil: Bundle? = nil) {
        self.init(name: name.rawValue, bundle: storyboardBundleOrNil)
    }

}

public protocol UIStoryboardHolder {

    var storyboard: UIStoryboard { get }

}

extension UIStoryboard: UIStoryboardHolder {

    public var storyboard: UIStoryboard { return self }

}

extension UIStoryboardHolder {

    public func instantiateInitialViewController<VC: UIViewController>() -> VC? {
        return storyboard.instantiateInitialViewController() as? VC
    }
    
    public func instantiateViewController<VC: UIViewController>() -> VC? {
        return storyboard.instantiateViewController(withIdentifier: VC.storyboardIdentifier.rawValue) as? VC
    }

    public func instantiateViewController(with identifier: UIViewController.StoryboardIdentifier) -> UIViewController {
        let vc = storyboard.instantiateViewController(withIdentifier: identifier.rawValue)
        
        if var vc = (vc as? StoryboardMutablyIdentifiable) {
             vc.storyboardMutableIdentifier = identifier
        }
    
        return vc
    }

}
