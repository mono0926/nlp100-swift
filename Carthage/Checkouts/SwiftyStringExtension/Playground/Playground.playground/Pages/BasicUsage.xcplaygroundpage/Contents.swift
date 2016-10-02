//: Playground - noun: a place where people can play

#if os(OSX)
import Cocoa
#elseif os(iOS)
import UIKit
#endif
import SwiftyStringExtension

var str = "Hello, playground"
str[sequentialAccess: 1..<3]