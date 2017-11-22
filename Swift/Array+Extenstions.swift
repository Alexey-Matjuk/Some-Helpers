//
//  Array+Extenstions.swift
//  Reisebank
//
//  Created by Uladzislau Herasiuk on 21.12.16.
//
//

import Foundation

public extension Array {
    
    public mutating func replace(with replacement: Element, at index: Int)  {
        guard count != 0, count > index else  {
            insert(replacement, at: 0)
            return
        }
        remove(at: index)
        insert(replacement, at: index)
    }
    
    public func appending(_ newElement: Element) -> Array {
        var result = self
        result.append(newElement)
        return result
    }
    
    public func appending<S: Sequence>(contentsOf sequence: S) -> Array where Element == S.Element {
        var result = self
        result.append(contentsOf: sequence)
        return result
    }

}
