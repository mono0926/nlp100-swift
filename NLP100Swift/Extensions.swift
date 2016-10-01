//
//  StringExtensions.swift
//  nlp100-swift
//
//  Created by mono on 8/31/16.
//
//

import Foundation


extension String: BidirectionalCollection, RangeReplaceableCollection {}

extension String {
    func nsRange(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)
        let to = range.upperBound.samePosition(in: utf16)
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from),
                       length: utf16.distance(from: from, to: to))
    }
}

extension String {
    subscript(sequentialAccess range: Range<Int>) -> String {
        return String(characters[sequentialAccess: range])
    }
    subscript(sequentialAccess index: Int) -> String? {
        return self[sequentialAccess: index..<index + 1]
    }
    var asciiCode: UInt32? {
        if unicodeScalars.index(after: unicodeScalars.startIndex) != unicodeScalars.endIndex { return nil }
        return characters.first!.asciiCode
    }
}

extension NSRange {
    func toRange(with string: String) -> Range<String.Index>? {
        let utf16 = string.utf16
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: string),
            let to = String.Index(to16, within: string)
            else { return nil }
        return from ..< to
    }
}

extension String.CharacterView {
    subscript(sequentialAccess range: Range<Int>) -> String.CharacterView {
        let lower = range.lowerBound
        let startIndex = index(self.startIndex, offsetBy: lower)
        let endIndex = index(startIndex, offsetBy: range.count)
        return self[startIndex..<endIndex]
    }
    subscript(sequentialAccess index: Int) -> String.CharacterView? {
        return self[sequentialAccess: index..<index + 1]
    }
}

extension Character
{
    init?(asciiCode: UInt32) {
        guard let scalar = UnicodeScalar(asciiCode), scalar.isASCII else {
            return nil
        }
        self = Character(scalar)
    }
    var asciiCode: UInt32? {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars
        if scalars.index(after: scalars.startIndex) != scalars.endIndex { return nil }
        guard let first = scalars.first, first.isASCII else { return nil }
        return first.value
    }
}

extension Collection {
    func shuffled() -> [Generator.Element] {
        var list = Array(self)
        list.shuffle()
        return list
    }
}

extension MutableCollection where Index == Int {
    mutating func shuffle() {
        let c = Int(count.toIntMax())
        guard c > 1 else { return }
        
        for i in 0..<(c - 1) {
            let j = Int(arc4random_uniform(UInt32(c - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}
