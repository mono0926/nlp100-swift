//
//  Chapter2.swift
//  nlp100-swift
//
//  Created by mono on 9/1/16.
//
//

import Foundation

struct Chapter2 {
    /** Linuxのwcコマンドでカウントした行数と同じ結果を返す */
    static func countNumberOfLines(_ input: String) -> Int {
        // NOTE: Linuxのwcコマンドは、改行数をカウントするので、それに合わせた。(改行で分割して要素数をcountすると、最終行が空行などの時にズレる)
        return input.characters.filter { String($0).rangeOfCharacter(from: CharacterSet.newlines) != nil }.count
    }
    
    static func getCol(from input: String, columnIndex: Int, separator: String) -> [String] {
        let lines = input.components(separatedBy: CharacterSet.newlines)
        return  lines.map { line in
            let values = line.components(separatedBy: separator)
            return values.count > columnIndex ? values[columnIndex] : ""
        }
    }
    static func merge(_ columns: [String], separator: String) -> String? {
        guard let c1 = columns.first else { return nil }
        let columns = Array(columns.dropFirst())
        let c1s = c1.components(separatedBy: CharacterSet.newlines)
        return columns.reduce(c1s) { sum, column in
            return zip(sum, column.components(separatedBy: CharacterSet.newlines))
            .map { [$0, $1].joined(separator: separator) }
        }
            .map { $0 == separator ? "" : $0 } // 空行にseparator文字が入ってしまっているのを除去
            .joined(separator: "\n")
    }
    static func head(_ input: String, n: Int) -> String {
        var newLinesCount = 0
        for (i, c) in input.characters.enumerated() {
            if newLinesCount == n {
                return input[sequentialAccess: 0..<i]!
            }
            if String(c).rangeOfCharacter(from: CharacterSet.newlines) != nil  {
                newLinesCount += 1
            }
        }
        return input
    }
    static func tail(_ input: String, n: Int) -> String {
        let nHead = countNumberOfLines(input) - n
        var newLinesCount = 0
        for (i, c) in input.characters.enumerated() {
            if newLinesCount == nHead {
                return input[sequentialAccess: i..<input.characters.count]!
            }
            if String(c).rangeOfCharacter(from: CharacterSet.newlines) != nil {
                newLinesCount += 1
            }
        }
        return input
    }
    static func split(_ input: String, l: Int) -> [String] {
        var numberOfLines = countNumberOfLines(input)
        var result = [String]()
        var input = input
        while numberOfLines > 0 {
            let block = head(input, n: l)
            numberOfLines -= l
            input = tail(input, n: numberOfLines)
            result.append(block)
        }
        return result
    }
    static func getUniqueValue(_ input: String, columnIndex: Int, separator: String) -> Set<String> {
        let values = getCol(from: input, columnIndex: columnIndex, separator: separator).filter { !$0.isEmpty }
        return Set(values)
    }
    static func getSortedLines(_ input: String, keyColumnIndex: Int, separator: String) -> [String] {
        return input.components(separatedBy: CharacterSet.newlines).filter { !$0.isEmpty }.enumerated().map { (value: $1, key: $1.components(separatedBy: separator)[keyColumnIndex], index: $0) }
            .sorted { x, y in
                if x.key == y.key {
                    return x.index < y.index
                }
                return x.key >= y.key
        }
            .map { $0.value }
    }
    static func getUniqValuesSortedByCount(_ input: String, keyColumnIndex: Int, separator: String) -> [Set<String>] {
        let values = getCol(from: input, columnIndex: keyColumnIndex, separator: separator).filter { !$0.isEmpty }
        let dict = toCountDictionary(values)
        return dict.reduce([Int: [String]]()) { sum, v in
            var sum = sum
            sum[v.value] = (sum[v.value] ?? []) + [v.key]
            return sum
        }
            .sorted { x, y in x.key > y.key }
            .map { Set($1) }
    }
    static func toCountDictionary(_ input: [String]) -> [String: Int] {
        return input.reduce([String: Int]()) { sum, v in
            var sum = sum
            sum[v] = (sum[v] ?? 0) + 1
            return sum
        }
    }
}
