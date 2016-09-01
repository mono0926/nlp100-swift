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
        return input.components(separatedBy: " ").map { $0.trimmingCharacters(in: CharacterSet(charactersIn: ",.")).characters.count }
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
    static func q5Word(_ input: String) -> [[String]] {
        return ngramWord(input, n: 2)
    }
    static func q5Char(_ input: String) -> [String] {
        return ngramChar(input, n: 2)
    }
    /**
    # 06. 集合
 
    "paraparaparadise"と"paragraph"に含まれる文字bi-gramの集合を，それぞれ, XとYとして求め，XとYの和集合，積集合，差集合を求めよ．さらに，'se'というbi-gramがXおよびYに含まれるかどうかを調べよ．
    */
    static func q6(_ input1: String, _ input2: String) -> (sum: Set<String>, diff1: Set<String>, diff2: Set<String>, product: Set<String>)  {
        let n = 2
        let X = ngramChar(input1, n: n)
        let Y = ngramChar(input2, n: n)
        let XSet = Set(X)
        let YSet = Set(Y)
        let sum = Set(X + Y)
        let diff1 = XSet.subtracting(YSet)
        let diff2 = YSet.subtracting(XSet)
        let product = XSet.intersection(YSet)
        return (sum: sum, diff1: diff1, diff2: diff2, product: product)
    }
    static func q6IsContainAsBiGram(sentence: String, word: String) -> Bool {
        let bigram = ngramChar(sentence, n: 2)
        return bigram.contains(word)
    }
    /**
    # 07. テンプレートによる文生成
 
    引数x, y, zを受け取り「x時のyはz」という文字列を返す関数を実装せよ．さらに，x=12, y="気温", z=22.4として，実行結果を確認せよ．
    */
    static func q7(x: Int, y: AnyObject, z: AnyObject) -> String {
        return "\(x)時の\(y)は\(z)"
    }
    /**
    # 08. 暗号文
 
    与えられた文字列の各文字を，以下の仕様で変換する関数cipherを実装せよ．
 
    - 英小文字ならば(219 - 文字コード)の文字に置換
    - その他の文字はそのまま出力
 
    この関数を用い，英語のメッセージを暗号化・復号化せよ．
    */
    static func q8(_ input: String) -> String {
        return cipher(input)
    }
    /**
    # 09. Typoglycemia
 
    スペースで区切られた単語列に対して，各単語の先頭と末尾の文字は残し，それ以外の文字の順序をランダムに並び替えるプログラムを作成せよ．ただし，長さが４以下の単語は並び替えないこととする．適当な英語の文（例えば"I couldn't believe that I could actually understand what I was reading : the phenomenal power of the human mind ."）を与え，その実行結果を確認せよ．
    */
    static func q9(_ input: String) -> String {
        let separator = " "
        var words = input.components(separatedBy: separator)
        guard words.count > 4 else { return input }
        let first = words.removeFirst()
        let last = words.removeLast()
        words.shuffle()
        return ([first] + words + [last]).joined(separator: separator)
    }
}

fileprivate extension Chapter1 {
    // TODO: ちょっと汚い(　´･‿･｀)
    fileprivate static func ngramWord(_ input: String, n: Int) -> [[String]] {
        let words = input.components(separatedBy: " ") + (0..<n-1).map { _ in "" }
        return words.reduce([[String]]()) { sum, word in
            var sum = sum
            var words: [String] = { () -> [String] in
                if let lasts = sum.last?.dropFirst() {
                    return Array(lasts)
                }
                return []
            }()
            words = (0..<(n - 1 - words.count)).map { _ in "" } + words
            sum.append(words + [word])
            return sum
        }
    }
    fileprivate static func ngramChar(_ input: String, n: Int) -> [String] {
        return input.characters.reduce([String]()) { sum, char in
            var sum = sum
            let count = sum.last?.characters.count ?? 0
            let first = sum.last?[count - (n - 1)..<count] ?? " "
            sum.append(first + String(char))
            return sum
            }.filter { !$0.contains(" ") }
    }
    fileprivate static func cipher(_ input: String) -> String {
        return input.characters.map { c in
            let s = String(c)
            let lowercased = s.lowercased()
            return lowercased == s ? String(Character(asciiCode: (219 - c.asciiCode()))!) : s
            }.joined(separator: "")
    }
}
