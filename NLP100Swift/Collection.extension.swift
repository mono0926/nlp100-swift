//
//  Collection.extension.swift
//  nlp100-swift
//
//  Created by mono on 2016/10/01.
//
//

import Foundation

extension Collection {
    
    public func shuffled() -> [Generator.Element] {
        var list = Array(self)
        list.shuffle()
        return list
    }
    
}

extension MutableCollection where Index == Int {
    
    public mutating func shuffle() {
        let c = Int(count.toIntMax())
        guard c > 1 else { return }
        
        for i in 0..<(c - 1) {
            let j = Int(arc4random_uniform(UInt32(c - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}
