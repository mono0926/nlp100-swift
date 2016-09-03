//
//  TestUtil.swift
//  nlp100-swift
//
//  Created by mono on 9/3/16.
//
//

import Foundation

class TestUtil {
    private static let bundle = Bundle(for: TestUtil.self)
    static func read(fromFile name: String) -> String {
        let path = bundle.path(forResource: name, ofType: "txt")!
        return try! String(contentsOfFile: path)
    }
}
