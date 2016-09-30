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
        XCTAssertEqual("foo"[sequentialAccess: 0..<0], "")
        XCTAssertEqual("foo"[sequentialAccess: 0..<1], "f")
        XCTAssertEqual("foo"[sequentialAccess: 0..<2], "fo")
        XCTAssertEqual("foo"[sequentialAccess: 0..<3], "foo")
        XCTAssertEqual("foo"[sequentialAccess: 0..<4], nil)
        XCTAssertEqual("foo"[sequentialAccess: 1..<1], "")
        XCTAssertEqual("foo"[sequentialAccess: 1..<2], "o")
        XCTAssertEqual("foo"[sequentialAccess: 1..<3], "oo")
        XCTAssertEqual("foo"[sequentialAccess: 1..<4], nil)
    }
    
    func testToAsciiCode() {
        XCTAssertEqual("A".asciiCode, 65)
        XCTAssertEqual("a".asciiCode, 97)
    }
    func testFromAsciiCode() {
        XCTAssertEqual(Character(asciiCode: 65), "A")
        XCTAssertEqual(Character(asciiCode: 97), "a")
    }
    // TODO: ランダムなので、たまに失敗するのが課題🤔
    func testShuffle() {
        let input = ["a", "b", "c", "d", "e"]
        let result = input.shuffled()
        XCTAssertNotEqual(result, input)
        XCTAssertEqual(Set(result), Set(input))
    }
    func testPrefix() {
        let input = "12345"
        XCTAssertEqual("1", input.prefix(upTo: input.index(input.startIndex, offsetBy: 1)))
        XCTAssertEqual("123", input.prefix(count: 3))
        XCTAssertEqual("12345", input.prefix(count: 5))
//        XCTAssertEqual("12345", input.prefix(count: 6)) //クラッシュ
        XCTAssertEqual(input, input.prefix(6))
    }
}
