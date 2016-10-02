//
//  String.CharacterView.extension.swift
//  SwiftyStringExtension
//
//  Created by mono on 2016/10/02.
//  Copyright © 2016 mono. All rights reserved.
//

import Foundation

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
