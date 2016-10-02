//
//  StringTests.swift
//  SwiftyStringExtension
//
//  Created by mono on 2016/10/02.
//  Copyright © 2016 mono. All rights reserved.
//

import XCTest
import SwiftyStringExtension
import Foundation

class StringTests: XCTestCase {
    
    func testSuscript() {
        let input = "abcd"
        XCTAssertEqual(input[sequentialAccess: 0..<0], "")
        XCTAssertEqual(input[sequentialAccess: 0..<1], "a")
        XCTAssertEqual(input[sequentialAccess: 0..<2], "ab")
        XCTAssertEqual(input[sequentialAccess: 0..<3], "abc")
        XCTAssertEqual(input[sequentialAccess: 0..<4], input)
        XCTAssertEqual(input[sequentialAccess: 2..<2], "")
        XCTAssertEqual(input[sequentialAccess: 2..<3], "c")
        XCTAssertEqual(input[sequentialAccess: 2..<4], "cd")
        XCTAssertEqual(input[sequentialAccess: 0], "a")
        XCTAssertEqual(input[sequentialAccess: 3], "d")
    }
    
    func testToAsciiCode() {
        XCTAssertEqual("A".asciiCode, 65)
        XCTAssertEqual("a".asciiCode, 97)
        XCTAssertNil("".asciiCode)
        XCTAssertNil("ab".asciiCode)
        XCTAssertNil("あ".asciiCode)
    }
    
    func testRemoveBound() {
        var s = "abcde"
        s.removeFirst(2)
        XCTAssertEqual(s, "cde")
        s.removeLast(2)
        XCTAssertEqual(s, "c")
    }
    
    func testToNSRange() {
        let s1 = "abcd"
        XCTAssertEqual(s1.makeNSRange(from: s1.startIndex..<s1.index(s1.startIndex, offsetBy: 2)).toRange()!, 0..<2)
        let s2 = "1️⃣2️⃣3️⃣4️⃣"
        XCTAssertEqual(s2.makeNSRange(from: s2.startIndex..<s2.index(s2.startIndex, offsetBy: 2)).toRange()!, 0..<6)
    }
    
    func testToRange() {
        let s1 = "abcd"
        XCTAssertEqual(s1.makeRange(from: NSRange(location: 0, length: 2)), s1.startIndex..<s1.index(s1.startIndex, offsetBy: 2))
        let s2 = "1️⃣2️⃣3️⃣4️⃣"
        XCTAssertEqual(s2.makeRange(from: NSRange(location: 0, length: 6)), s2.startIndex..<s2.index(s2.startIndex, offsetBy: 2))
        XCTAssertNil(s2.makeRange(from: NSRange(location: 0, length: 50)))
    }
}
