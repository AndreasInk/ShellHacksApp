//
//  Quiz.swift
//  ShellHacksApp
//
//  Created by Andreas on 9/25/21.
//

import SwiftUI
import SFSafeSymbols

struct Course {
    var id: String
    var quizzes: [Quiz]
    var tag: String
    var image: SFSymbol
}
struct Quiz: Codable {
    var id: String
    var questions: [Question]
    var tag: String
    var image: SFSymbol.RawValue
    var accuracy: Double?
}

struct Question: Codable {
    var id: String
    var questionStr: String
    var a: String
    var b: String
    var c: String
    var correct: String
    var picked: String
    var tag: String?
    var image: SFSymbol.RawValue?
}

struct APIInput: Codable {
    var id: String
    var text: String
}
