//
//  String.extension.swift
//  nlp100-swift
//
//  Created by mono on 2016/10/01.
//
//

import Foundation

// Enable collection operation
extension String: BidirectionalCollection, RangeReplaceableCollection {}

extension String {
    
    // MARK: - Subscript
    public subscript(sequentialAccess range: Range<Int>) -> String {
        return String(characters[sequentialAccess: range])
    }
    
    public subscript(sequentialAccess index: Int) -> String {
        return self[sequentialAccess: index..<index + 1]
    }
    
    // MARK: - Other    
    public var asciiCode: UInt32? {
        if unicodeScalars.index(after: unicodeScalars.startIndex) != unicodeScalars.endIndex { return nil }
        return characters.first?.asciiCode
    }
    
    // MARK: - Bug?
    public mutating func removeFirst(_ n: Int) {
        characters.removeFirst(n)
    }
    
    public mutating func removeLast(_ n: Int) {
        characters.removeLast(n)
    }
    
    // MARK: - Range
    public func makeNSRange(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)
        let to = range.upperBound.samePosition(in: utf16)
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from),
                       length: utf16.distance(from: from, to: to))
    }
    
    public func makeRange(from range: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: range.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: range.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }
}
