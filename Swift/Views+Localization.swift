//
//  Views+Localization.swift
//  Reisebank
//
//  Created by Alexey Matjuk on 11/29/16.
//
//


public func LocalizedString(_ key: String, comment: String = "") -> String {
    return NSLocalizedString(key, comment: comment)
}

extension UILabel {
    
    @IBInspectable var localizedText: String? {
        set {
            text = LocalizedString(newValue ?? "")
        }
        get {
            return text
        }
    }
    
}

extension UINavigationItem {

    @IBInspectable var localizedTitle: String? {
        set {
            title = LocalizedString(newValue ?? "")
        }
        get {
            return title
        }
    }

}

extension UITextField {
    
    @IBInspectable var localizedTitle: String? {
        set {
            text = LocalizedString(newValue ?? "")
        }
        get {
            return text
        }
    }
    
    @IBInspectable var localizedPlaceholder: String? {
        set {
            placeholder = LocalizedString(newValue ?? "")
        }
        get {
            return placeholder
        }
    }

}

extension UIBarButtonItem {

    @IBInspectable var localizedTitle: String? {
        set {
            title = LocalizedString(newValue ?? "")
        }
        get {
            return title
        }
    }

}

extension UITabBarItem {
    
    @IBInspectable var localizedTitle: String? {
        set {
            title = LocalizedString(newValue ?? "")
        }
        get {
            return title
        }
    }
    
}

extension UIButton {
    
    @IBInspectable var localizedNormalTitle: String? {
        set {
            setTitle(LocalizedString(newValue ?? ""), for: .normal)
        }
        get {
            return title(for: .normal)
        }
    }

    @IBInspectable var localizedHighlightedTitle: String? {
        set {
            setTitle(LocalizedString(newValue ?? ""), for: .highlighted)
        }
        get {
            return title(for: .highlighted)
        }
    }

    @IBInspectable var localizedDisabledTitle: String? {
        set {
            setTitle(LocalizedString(newValue ?? ""), for: .disabled)
        }
        get {
            return title(for: .disabled)
        }
    }

}

extension ResizebleTextView {
    
    @IBInspectable var localizedPlaceholder: String? {
        set {
            placeholder = LocalizedString(newValue ?? "")
        }
        get {
            return placeholder
        }
    }
}

extension UISegmentedControl {
    
    @IBInspectable var localizedFirstTitle: String? {
        set {
            guard numberOfSegments > 0 else { return }
            setTitle(LocalizedString(newValue ?? ""), forSegmentAt: 0)
        }
        get {
            guard numberOfSegments > 0 else { return nil }
            return titleForSegment(at: 0)
        }
    }
    
    @IBInspectable var localizedSecondTitle: String? {
        set {
            guard numberOfSegments > 1 else { return }
            self.setTitle(LocalizedString(newValue ?? ""), forSegmentAt: 1)
        }
        get {
            guard numberOfSegments > 1 else { return nil }
            return titleForSegment(at: 1)
        }
    }
    
}
