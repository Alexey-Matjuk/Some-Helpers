//
//  NSNumber+Extenstions.swift
//  Reisebank
//
//  Created by Alexey Matjuk on 3/22/17.
//
//

import Foundation


extension NSNumber: Comparable {
    
    public static func <(lhs: NSNumber, rhs: NSNumber) -> Bool {
        return lhs.compare(rhs) == .orderedAscending
    }
    
    public static func >(lhs: NSNumber, rhs: NSNumber) -> Bool {
        return lhs.compare(rhs) == .orderedDescending
    }
    
    public static func <=(lhs: NSNumber, rhs: NSNumber) -> Bool {
        return (lhs < rhs)  || (lhs == rhs)
    }
    
    public static func >=(lhs: NSNumber, rhs: NSNumber) -> Bool {
        return (lhs > rhs) || (lhs == rhs)
    }
    
}
