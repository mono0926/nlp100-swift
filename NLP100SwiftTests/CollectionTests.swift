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
    // TODO: ランダムなので、たまに失敗するのが課題🤔
    func testShuffle() {
        let input = ["a", "b", "c", "d", "e"]
        let result = input.shuffled()
        XCTAssertNotEqual(result, input)
        XCTAssertEqual(Set(result), Set(input))
    }
}
