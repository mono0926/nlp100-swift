//
//  Character.extension.swift
//  SwiftyStringExtension
//
//  Created by mono on 2016/10/02.
//  Copyright © 2016 mono. All rights reserved.
//

import Foundation

extension Character
{
    public init?(asciiCode: UInt32) {
        guard let scalar = UnicodeScalar(asciiCode), scalar.isASCII else {
            return nil
        }
        self = Character(scalar)
    }
    
    public var unicodeScalar: UnicodeScalar {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars
        // more than one scalar is not possible
        assert(scalars.index(after: scalars.startIndex) == scalars.endIndex)
        return scalars.first!
    }
    
    public var asciiCode: UInt32? {
        let unicodeScalar = self.unicodeScalar
        guard unicodeScalar.isASCII else { return nil }
        return unicodeScalar.value
    }
}
