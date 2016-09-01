//
//  NLP100SwiftTests.swift
//  NLP100SwiftTests
//
//  Created by mono on 8/31/16.
//
//

import XCTest
@testable import NLP100Swift

class NLP100SwiftTests: XCTestCase {
    func testQ0() {
        XCTAssertEqual(Chapter1.q0("stressed"), "desserts")
    }
    func testQ1() {
        XCTAssertEqual(Chapter1.q1("パタトクカシーー"), "タクシー")
    }
    func testQ2() {
        XCTAssertEqual(Chapter1.q2("パトカー", "タクシー"), "パタトクカシーー")
    }
    func testQ3() {
        XCTAssertEqual(Chapter1.q3("Now I need a drink, alcoholic of course, after the heavy lectures involving quantum mechanics."), [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5, 8, 9, 7, 9])
    }
    func testQ4() {
        XCTAssertEqual(
            Chapter1.q4("Hi He Lied Because Boron Could Not Oxidize Fluorine. New Nations Might Also Sign Peace Security Clause. Arthur King Can.", condition: [1, 5, 6, 7, 8, 9, 15, 16, 19]),
            ["H": 1, "Ne": 10, "Be": 4, "Al": 13, "B": 5, "O": 8, "Li": 3, "F": 9, "He": 2, "S": 16, "Cl": 17, "K": 19, "Ar": 18, "C": 6, "N": 7, "Mi": 12, "Si": 14, "Ca": 20, "P": 15, "Na": 11])
    }
    func testQ5Word() {
        let result = Chapter1.q5Word("I am an NLPer")
        print(result)
        let expected = [["", "I"], ["I", "am"], ["am", "an"], ["an", "NLPer"], ["NLPer", ""]]
        XCTAssertEqual(result.count, expected.count)
        result.enumerated().forEach {
            XCTAssertEqual($1[0], expected[$0][0])
            XCTAssertEqual($1[1], expected[$0][1])
        }
    }
    func testQ5Char() {
        let result = Chapter1.q5Char("I am an NLPer")
        let expected = ["am", "an", "NL", "LP", "Pe", "er"]
        XCTAssertEqual(result, expected)
    }
    func testQ6() {
        let input1 = "paraparaparadise"
        let input2 = "paragraph"
        let result = Chapter1.q6(input1, input2)
        XCTAssertEqual(result.sum, Set(["pa", "se", "ad", "ap", "ra", "gr", "ag", "ph", "ar", "di", "is"]))
        XCTAssertEqual(result.diff1, Set(["se", "ad", "di", "is"]))
        XCTAssertEqual(result.diff2, Set(["gr", "ag", "ph"]))
        XCTAssertEqual(result.product, Set(["pa", "ar", "ap", "ra"]))
        let word = "se"
        XCTAssertTrue(Chapter1.q6IsContainAsBiGram(sentence: input1, word: word))
        XCTAssertFalse(Chapter1.q6IsContainAsBiGram(sentence: input2, word: word))
    }
    func testQ7() {
        XCTAssertEqual(Chapter1.q7(x: 12, y: "気温" as AnyObject, z: 22.4 as AnyObject), "12時の気温は22.4")
    }
    func testQ8() {
        XCTAssertEqual(Chapter1.q8("Masayuki Ono"), "Mzhzbfpr»Oml")
        XCTAssertEqual(Chapter1.q8("Mzhzbfpr»Oml"), "Masayuki Ono")
    }
    func testQ9() {
        let inputLong = "I couldn't believe that I could actually understand what I was reading : the phenomenal power of the human mind ."
        let resultLong = Chapter1.q9(inputLong)
        print("Q9. resultLong: \(resultLong)")
        XCTAssertNotEqual(resultLong, inputLong)
        XCTAssertTrue(resultLong.hasPrefix("I "))
        XCTAssertTrue(resultLong.hasSuffix(" ."))
        let inputShort = "I couldn't believe ."
        let resultShort = Chapter1.q9(inputShort)
        XCTAssertEqual(resultShort, inputShort)
        
    }
}
