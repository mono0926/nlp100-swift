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
        return input.characters.filter { CharacterSet.newlines.isContain($0) }.count
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
                return input[0..<i]!
            }
            if CharacterSet.newlines.isContain(c)  {
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
                return input[i..<input.characters.count]!
            }
            if CharacterSet.newlines.isContain(c) {
                newLinesCount += 1
            }
        }
        return input
    }
}
