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
    static func read(fromFile name: String, type: String? = "txt") -> String {
        let path = bundle.path(forResource: name, ofType: type)!
        return try! String(contentsOfFile: path)
    }
}
