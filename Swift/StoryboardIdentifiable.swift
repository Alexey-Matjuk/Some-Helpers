//
//  StoryboardIdentifiable.swift
//  Reisebank
//
//  Created by Alexey Matjuk on 11/21/16.
//
//

import UIKit

extension UIViewController {
    
    public struct StoryboardIdentifier: _RawRepresentable, Hashable {
        
        public let rawValue: String
        
        public var hashValue: Int { return self.rawValue.hashValue }
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
    
}

public protocol StoryboardIdentifiable {
    
    static var storyboardIdentifier: UIViewController.StoryboardIdentifier { get }
    
}

//Use it instead of StoryboardIdentifiable in case of reusing viewControllers 
//with small design changes(to change xib you need change storyboard ID to some another).
//See example: AppPINViewController(used in SingUpAppPIN.stroryboard and ChangeAppPIN.storyboard).
public protocol StoryboardMutablyIdentifiable: StoryboardIdentifiable {
    
    var storyboardMutableIdentifier: UIViewController.StoryboardIdentifier { get set }
    
}

extension UIViewController: StoryboardIdentifiable {
    
    public static var storyboardIdentifier: UIViewController.StoryboardIdentifier {
        return UIViewController.StoryboardIdentifier(rawValue: String(describing: self))
    }
    
}






