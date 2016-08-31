//
//  Chapter1.swift
//  nlp100-swift
//
//  Created by mono on 8/31/16.
//
//

import Foundation

struct Chapter1 {
    /**
    # 00. 文字列の逆順
     
     文字列"stressed"の文字を逆に（末尾から先頭に向かって）並べた文字列を得よ．
    */
    static func q0(_ input: String) -> String {
        return String(input.characters.reversed())
    }
    /**
    # 01. 「パタトクカシーー」
     
     「パタトクカシーー」という文字列の1,3,5,7文字目を取り出して連結した文字列を得よ．
    */
    static func q1(_ input: String) -> String {
        return String(input.characters.enumerated().filter { i, _ in i % 2 == 1 }.map { $1 })
    }
    /**
    # 02. 「パトカー」＋「タクシー」＝「パタトクカシーー」
 
    「パトカー」＋「タクシー」の文字を先頭から交互に連結して文字列「パタトクカシーー」を得よ．
    */
    static func q2(_ input1: String, _ input2: String) -> String {
        return zip(input1.characters, input2.characters).map { String($0) + String($1) }.reduce("") { sum, e in sum + e }
    }
    /**
    # 03. 円周率
 
    "Now I need a drink, alcoholic of course, after the heavy lectures involving quantum mechanics."という文を単語に分解し，各単語の（アルファベットの）文字数を先頭から出現順に並べたリストを作成せよ．
    */
    static func q3(_ input: String) -> [Int] {
        return input.components(separatedBy: " ").map { $0.characters.count }
    }
    /**
    # 04. 元素記号
    
    "Hi He Lied Because Boron Could Not Oxidize Fluorine. New Nations Might Also Sign Peace Security Clause. Arthur King Can."という文を単語に分解し，1, 5, 6, 7, 8, 9, 15, 16, 19番目の単語は先頭の1文字，それ以外の単語は先頭に2文字を取り出し，取り出した文字列から単語の位置（先頭から何番目の単語か）への連想配列（辞書型もしくはマップ型）を作成せよ．
    */
    static func q4(_ input: String, condition: [Int]) -> [String: Int] {
        return input.components(separatedBy: " ").enumerated()
            .map { (i, v) in condition.contains(i + 1) ? (i, v[0..<1]!) : (i, v[0..<2]!) }
            .reduce([String: Int]()) { sum, v in
                var sum = sum
                sum[v.1] = v.0 + 1
                return sum
        }
    }
    /**
    # 05. n-gram
     
     与えられたシーケンス（文字列やリストなど）からn-gramを作る関数を作成せよ．この関数を用い，"I am an NLPer"という文から単語bi-gram，文字bi-gramを得よ．
    */
    static func q5Word(_ input: String) -> [(String, String)] {
        return ngramWord(input, n: 2)
    }
    static func q5Char(_ input: String) -> [String] {
        return ngramChar(input, n: 2)
    }
}

// TODO: n使い忘れてたので直す(´・︵・｀)
fileprivate extension Chapter1 {
    fileprivate static func ngramWord(_ input: String, n: Int) -> [(String, String)] {
        let words = input.components(separatedBy: " ") + [""]
        return words.reduce([(String, String)]()) { sum, word in
            var sum = sum
            let first: String = sum.last?.1 ?? ""
            sum.append((first, word))
            return sum
        }
    }
    fileprivate static func ngramChar(_ input: String, n: Int) -> [String] {
        return input.characters.reduce([String]()) { sum, char in
            var sum = sum
            let count = sum.last?.characters.count ?? 0
            let first = sum.last?[count-1..<count] ?? " "
            sum.append(first + String(char))
            return sum
            }.filter { !$0.contains(" ") }
    }
}
