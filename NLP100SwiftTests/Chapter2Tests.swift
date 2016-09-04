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
    /**
    # 16. ファイルをN分割する
 
    自然数Nをコマンドライン引数などの手段で受け取り，入力のファイルを行単位でN分割せよ．同様の処理をsplitコマンドで実現せよ．
     
     注: `plit -l 10 hightemp.txt`で結果を得た。
    */
    func test16() {
        let result = Chapter2.split(targetContent, l: 10)
        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(result[0], TestUtil.read(fromFile: "xaa", type: nil))
        XCTAssertEqual(result[1], TestUtil.read(fromFile: "xab", type: nil))
        XCTAssertEqual(result[2], TestUtil.read(fromFile: "xac", type: nil))
    }
    /**
    # 17. １列目の文字列の異なり
 
    1列目の文字列の種類（異なる文字列の集合）を求めよ．確認にはsort, uniqコマンドを用いよ．
    
    注: `cut -f1 hightemp.txt | sort | uniq > hightemp_c1sortuniq.txt`で結果を得た。
    */
    func test17() {
        let expected = Set(TestUtil.read(fromFile: "hightemp_c1sortuniq").components(separatedBy: CharacterSet.newlines).filter { !$0.isEmpty })
        XCTAssertEqual(Chapter2.getUniqueValue(targetContent, columnIndex: 0, separator: "\t"), expected)
    }
    /**
    # 18. 各行を3コラム目の数値の降順にソート
 
    各行を3コラム目の数値の逆順で整列せよ（注意: 各行の内容は変更せずに並び替えよ）．確認にはsortコマンドを用いよ（この問題はコマンドで実行した時の結果と合わなくてもよい）
     
     注: `sort -k3 -r hightemp.txt > hightemp_sortk3r.txt`の結果が安定ソートでは無かったので、2・3行目を手動で入れ替えた(問題の注釈にもあり)
    */
    func test18() {
        let expected = TestUtil.read(fromFile: "hightemp_sortk3r").components(separatedBy: CharacterSet.newlines).filter { !$0.isEmpty }
        XCTAssertEqual(Chapter2.getSortedLines(targetContent, keyColumnIndex: 2, separator: "\t"), expected)
    }
    /**
    # 19. 各行の1コラム目の文字列の出現頻度を求め，出現頻度の高い順に並べる
 
    各行の1列目の文字列の出現頻度を求め，その高い順に並べて表示せよ．確認にはcut, uniq, sortコマンドを用いよ．
     
     注: `cut -f1 hightemp.txt | sort | uniq -c | sort -k1 -r > hightemp_sortf1count.txt`した結果を手で加工
    */
    func test19() {
        let expected1 = Set(["群馬県","山梨県","山形県","埼玉県"])
        let expected2 = Set(["静岡県","愛知県","岐阜県","千葉県"])
        let expected3 = Set(["和歌山県","高知県","愛媛県","大阪府"])
        let result = Chapter2.getUniqValuesSortedByCount(targetContent, keyColumnIndex: 0, separator: "\t")
        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(result[0], expected1)
        XCTAssertEqual(result[1], expected2)
        XCTAssertEqual(result[2], expected3)
        
    }
}
