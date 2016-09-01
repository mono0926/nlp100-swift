//
//  StringExtensions.swift
//  nlp100-swift
//
//  Created by mono on 8/31/16.
//
//

import Foundation

extension String {
    
    subscript (range: Range<Int>) -> String? {
        let count = characters.count
        let lower = range.lowerBound
        let upper = range.upperBound
        if lower >= count || upper > count { return nil }
        let startIndex = characters.index(characters.startIndex, offsetBy: lower)
        let endIndex = characters.index(characters.startIndex, offsetBy: upper)
        return String(characters[startIndex..<endIndex])
    }
    func asciiCode() -> UInt32? {
        guard characters.count == 1 else { return nil }
        return characters.first!.asciiCode()
    }
}

extension Character
{
    func asciiCode() -> UInt32 {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars
        
        return scalars[scalars.startIndex].value
    }
    init?(asciiCode: UInt32) {
        guard let scalar = UnicodeScalar(asciiCode) else {
            return nil
        }        
        self = Character(scalar)
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
