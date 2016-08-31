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
}
