//
//  QuizView.swift
//  ShellHacksApp
//
//  Created by Andreas on 9/25/21.
//

import SwiftUI

struct QuizView: View {
    @State var quiz: Quiz
    var body: some View {
        ForEach($quiz.questions, id: \.id) { $question in
            QuestionsView(question: $question)
        }
    }
}

