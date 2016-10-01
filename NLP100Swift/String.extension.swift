//
//  String.extension.swift
//  nlp100-swift
//
//  Created by mono on 2016/10/01.
//
//

import Foundation

extension String: BidirectionalCollection, RangeReplaceableCollection {}

extension String {
    
    public func nsRange(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)
        let to = range.upperBound.samePosition(in: utf16)
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from),
                       length: utf16.distance(from: from, to: to))
    }
    
    public subscript(sequentialAccess range: Range<Int>) -> String {
        return String(characters[sequentialAccess: range])
    }
    
    public subscript(sequentialAccess index: Int) -> String {
        return self[sequentialAccess: index..<index + 1]
    }
    
    public var asciiCode: UInt32? {
        if unicodeScalars.index(after: unicodeScalars.startIndex) != unicodeScalars.endIndex { return nil }
        return characters.first!.asciiCode
    }
    
    public mutating func removeFirst(_ n: Int) {
        characters.removeFirst(n)
    }
    
    public mutating func removeLast(_ n: Int) {
        characters.removeLast(n)
    }
}

extension String.CharacterView {
    
    public subscript(sequentialAccess range: Range<Int>) -> String.CharacterView {
        let lower = range.lowerBound
        let startIndex = index(self.startIndex, offsetBy: lower)
        let endIndex = index(startIndex, offsetBy: range.count)
        return self[startIndex..<endIndex]
    }
    
    public subscript(sequentialAccess index: Int) -> Character {
        return self[sequentialAccess: index..<index + 1].first!
    }
    
}

extension Character
{
    public init?(asciiCode: UInt32) {
        guard let scalar = UnicodeScalar(asciiCode), scalar.isASCII else {
            return nil
        }
        self = Character(scalar)
    }
    
    public var asciiCode: UInt32? {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars
        if scalars.index(after: scalars.startIndex) != scalars.endIndex { return nil }
        guard let first = scalars.first, first.isASCII else { return nil }
        return first.value
    }
}
