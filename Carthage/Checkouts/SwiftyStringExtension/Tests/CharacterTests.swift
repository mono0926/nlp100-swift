//
//  Tests.swift
//  Tests
//
//  Created by mono on 2016/10/02.
//  Copyright © 2016 mono. All rights reserved.
//

import XCTest
import SwiftyStringExtension

class CharacterTests: XCTestCase {
    
    func testFromAsciiCode() {
        XCTAssertEqual(Character(asciiCode: 65), "A")
        XCTAssertEqual(Character(asciiCode: 97), "a")
        XCTAssertNil(Character(asciiCode: 1000))
    }
}
