//
//  String+Extensions.swift
//  Reisebank
//
//  Created by Alexey Matjuk on 11/21/16.
//
//

import Foundation

extension String {
    
    public subscript(i: IndexDistance) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    public subscript(range: Range<IndexDistance>) -> String {
        return String(self[index(startIndex, offsetBy: range.lowerBound)..<index(startIndex, offsetBy: range.upperBound)])
    }
    
    public subscript(range: ClosedRange<IndexDistance>) -> String {
        return String(self[index(startIndex, offsetBy: range.lowerBound)...index(startIndex, offsetBy: range.upperBound)])
    }
    
    public subscript(s: String) -> Range<Index>? {
        return range(of: s)
    }
    
    public mutating func replaceSubrange(_ bounds: Range<IndexDistance>, with newElements: String) {
        replaceSubrange(index(startIndex, offsetBy: bounds.lowerBound)..<index(startIndex, offsetBy: bounds.upperBound), with: newElements)
    }
    
    public mutating func replaceSubrange(_ bounds: ClosedRange<IndexDistance>, with newElements: String) {
        replaceSubrange(index(startIndex, offsetBy: bounds.lowerBound)...index(startIndex, offsetBy: bounds.upperBound), with: newElements)
    }

    public func replacingCharacters(in bounds: Range<IndexDistance>, with newElements: String) -> String {
        return replacingCharacters(in: index(startIndex, offsetBy: bounds.lowerBound)..<index(startIndex, offsetBy: bounds.upperBound), with: newElements)
    }
    
    public func replacingCharacters(in bounds: ClosedRange<IndexDistance>, with newElements: String)  -> String {
        return replacingCharacters(in: index(startIndex, offsetBy: bounds.lowerBound)..<index(startIndex, offsetBy: bounds.upperBound), with: newElements)
    }
    
    public func prefix(_ maxLength: Int) -> String {
        return String(prefix(maxLength))
    }

    public func suffix(_ maxLength: Int) -> String {
        return String(suffix(maxLength))
    }

    public static func generateID() -> String {
        let refId = UUID().uuidString
        return refId.replacingOccurrences(of: "-", with: "")
    }
    
    public var isNotEmpty: Bool { return !isEmpty }

    public mutating func removeLastIfPossible() {
        guard count > 0 else { return }
        removeLast()
    }

    public func removingFirst(_ n: Int = 1) -> String {
        var result = self
        result.removeFirst(min(count, n))
        return result
    }

    public func removingLast(_ n: Int = 1) -> String {
        var result = self
        result.removeLast(min(count, n))
        return result
    }

    public func contains(anyOf otherStrings: [String]) -> Bool {
        for otherString in otherStrings {
            guard otherString.isNotEmpty, contains(otherString) else { continue }
            return true
        }
        return false
    }

    public func contains(anyOf otherStrings: String...) -> Bool {
        return contains(anyOf: otherStrings)
    }

    public func contains(allOf otherStrings: [String]) -> Bool {
        for otherString in otherStrings {
            guard otherString.isNotEmpty, !contains(otherString) else { continue }
            return false
        }
        return true
    }

    public func contains(allOf otherStrings: String...) -> Bool {
        return contains(anyOf: otherStrings)
    }

}

public struct WhitespaceDirection : OptionSet {

    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let left  = WhitespaceDirection(rawValue: 1 << 0)
    public static let right  = WhitespaceDirection(rawValue: 1 << 1)
    public static let none = WhitespaceDirection(rawValue: 1 << 2)
    
    public static let all: WhitespaceDirection = [.left, .right]

}

extension String {
    
    public func trimmingWhitespaces(from direction: WhitespaceDirection = .all) -> String {
        switch direction {
        case [.all]:
            return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        case [.left] where first == " ":
            return removingFirst().trimmingWhitespaces(from: direction)
        case [.right] where last == " ":
            return removingLast().trimmingWhitespaces(from: direction)
        default:
            return self
        }
    }
    
    public func substrings(withMaxLength length: Int = 4) -> [String] {
        var result: [String] = []
        for index in stride(from: 0 ,to: count, by: length) {
            result.append(String(self[index..<min(index + length, count)]))
        }
        
        return result
    }
    
}

public extension String {
    
    static let PINMaxLength = 4
    static let MTANMaxLength = 8
    
}

