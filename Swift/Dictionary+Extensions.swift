//
//  Dictionary+Extensions.swift
//  Reisebank
//
//  Created by Vova Tanakov on 11/30/16.
//
//

import Foundation

extension Dictionary {
    
    public mutating func merge(with dictionary: [Key: Value], override: Bool = true) {
        for (key, value) in dictionary where override || !self.keys.contains(key) {
            self[key] = value
        }
    }
    
    public func merged(with dictionary: [Key: Value], override: Bool = true) -> [Key: Value] {
        var merged = self
        for (key, value) in dictionary where override || !merged.keys.contains(key){
            merged[key] = value
        }
        return merged
    }
    
}

extension Dictionary {
    
    init(_ pairs: [Element]) {
        self.init()
        for (k, v) in pairs {
            self[k] = v
        }
    }
    
}

extension Dictionary {
    
    func map<OutValue>(transform: (Value) throws -> OutValue) rethrows -> [Key: OutValue] {
        return [Key:OutValue](try map { (k, v) in (k, try transform(v)) })
    }
    
    func flatMap<OutValue>(transform: (Value) throws -> OutValue?) rethrows -> [Key: OutValue] {
        var result = [Key: OutValue]()
        for (_, keyValue) in enumerated() {
            guard let transformedValue = try transform(keyValue.value) else { continue }
            result[keyValue.key] = transformedValue
        }
        return result
    }

}
