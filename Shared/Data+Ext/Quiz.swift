//
//  Quiz.swift
//  ShellHacksApp
//
//  Created by Andreas on 9/25/21.
//

import SwiftUI
import SFSafeSymbols
struct Quiz {
    var id: String
    var questions: [Question]
    var tags: [String]
    var image: SFSymbol
}

struct Question {
    var id: String
    var questionStr: String
    var a: String
    var b: String
    var c: String
    var correct: String
    var picked: String
}
