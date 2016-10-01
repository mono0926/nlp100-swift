//
//  Range.extension.swift
//  nlp100-swift
//
//  Created by mono on 2016/10/01.
//
//

import Foundation

extension NSRange {
    
    public func toRange(with string: String) -> Range<String.Index>? {
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
