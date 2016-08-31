//
//  StringExtensionsTests.swift
//  nlp100-swift
//
//  Created by mono on 8/31/16.
//
//
import XCTest
@testable import NLP100Swift

class StringExtensionsTests: XCTestCase {
    func testSuscript() {
        XCTAssertEqual("foo"[0..<0], "")
        XCTAssertEqual("foo"[0..<1], "f")
        XCTAssertEqual("foo"[0..<2], "fo")
        XCTAssertEqual("foo"[0..<3], "foo")
        XCTAssertEqual("foo"[0..<4], nil)
        XCTAssertEqual("foo"[1..<1], "")
        XCTAssertEqual("foo"[1..<2], "o")
        XCTAssertEqual("foo"[1..<3], "oo")
        XCTAssertEqual("foo"[1..<4], nil)
    }
}
