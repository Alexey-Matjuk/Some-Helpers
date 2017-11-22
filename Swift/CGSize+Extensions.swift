//
//  CGSize+Extensions.swift
//  Reisebank
//
//  Created by Alexey Matjuk on 12/21/16.
//
//

import UIKit

public extension CGSize {
    
    var integral: CGSize {
        return CGSize(width: round(width), height: round(height))
    }
    
}
