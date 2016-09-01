//
//  StringExtensionsTests.swift
//  nlp100-swift
//
//  Created by mono on 8/31/16.
//
//
import XCTest
@testable import NLP100Swift

class ExtensionsTests: XCTestCase {
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
    
    func testToAsciiCode() {
        XCTAssertEqual("A".asciiCode(), 65)
        XCTAssertEqual("a".asciiCode(), 97)
    }
    func testFromAsciiCode() {
        XCTAssertEqual(Character(asciiCode: 65), "A")
        XCTAssertEqual(Character(asciiCode: 97), "a")
    }
    // TODO: ランダムなので、たまに失敗するのが課題🤔
    func testShuffle() {
        let input = ["a", "b", "c", "d", "e"]
        XCTAssertNotEqual(input.shuffled(), input)
    }
}
