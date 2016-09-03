//
//  Chapter2Tests.swift
//  nlp100-swift
//
//  Created by mono on 9/1/16.
//
//

import XCTest
@testable import NLP100Swift

class Chapter2Tests: XCTestCase {
    private let filename = "hightemp"
    private var targetContent: String { return TestUtil.read(fromFile: filename) }
    /**
    # 10. 行数のカウント
    
    行数をカウントせよ．確認にはwcコマンドを用いよ．
    注: `wc hightemp.txt`と同一結果
    */
    func test10() {
        XCTAssertEqual(Chapter2.countNumberOfLines(targetContent), 24)
    }
    /**
    # 11. タブをスペースに置換
 
    タブ1文字につきスペース1文字に置換せよ．確認にはsedコマンド，trコマンド，もしくはexpandコマンドを用いよ．
    注: `cat hightemp.txt | tr '\t' ' '`と同一結果
    */
    func test11() {
        let expected = TestUtil.read(fromFile: "hightemp_tab2space")
        // NOTE: 標準メソッド呼ぶだけで完結
        XCTAssertEqual(targetContent.replacingOccurrences(of: "\t", with: " "), expected)
    }
    /**
    # 12. 1列目をcol1.txtに，2列目をcol2.txtに保存
 
    各行の1列目だけを抜き出したものをcol1.txtに，2列目だけを抜き出したものをcol2.txtとしてファイルに保存せよ．確認にはcutコマンドを用いよ．
    注: 以下で結果を得た
     
     - `cut -f1 hightemp.txt > hightemp_c1.txt`
     - `cut -f2 hightemp.txt > hightemp_c2.txt`
    */
    func test12() {
        let separator = "\t"
        let col1 = Chapter2.getCol(from: targetContent, columnIndex: 0, separator: separator)
        let col2 = Chapter2.getCol(from: targetContent, columnIndex: 1, separator: separator)
        XCTAssertEqual(col1.joined(separator: "\n"), TestUtil.read(fromFile: "hightemp_c1"))
        XCTAssertEqual(col2.joined(separator: "\n"), TestUtil.read(fromFile: "hightemp_c2"))
    }
    /**
    # 13. col1.txtとcol2.txtをマージ

    12で作ったcol1.txtとcol2.txtを結合し，元のファイルの1列目と2列目をタブ区切りで並べたテキストファイルを作成せよ．確認にはpasteコマンドを用いよ．
 
    注: `paste hightemp_c1.txt hightemp_c2.txt `で結果を得た
    */
    func test13() {
        let result = Chapter2.merge([TestUtil.read(fromFile: "hightemp_c1"), TestUtil.read(fromFile: "hightemp_c2")], separator: "\t")
        print("result: \(result)")
        XCTAssertEqual(result, TestUtil.read(fromFile: "hightemp_c1+2"))
    }
    /**
    # 14. 先頭からN行を出力

    自然数Nをコマンドライン引数などの手段で受け取り，入力のうち先頭のN行だけを表示せよ．確認にはheadコマンドを用いよ．
    
     注: `head -n 3 hightemp.txt > hightemp_headn3.txt`で結果を得た
    */
    func test14() {
        XCTAssertEqual(Chapter2.head(targetContent, n: 3), TestUtil.read(fromFile: "hightemp_headn3"))
    }
    /**
    # 15. 末尾のN行を出力

    自然数Nをコマンドライン引数などの手段で受け取り，入力のうち末尾のN行だけを表示せよ．確認にはtailコマンドを用いよ．
     
     注: `tail -n 3 hightemp.txt > hightemp_tailn3.txt`で結果を得た
    */
    func test15() {
        XCTAssertEqual(Chapter2.tail(targetContent, n: 3), TestUtil.read(fromFile: "hightemp_tailn3"))
    }
}
