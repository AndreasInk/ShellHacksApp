//
//  QuizView.swift
//  ShellHacksApp
//
//  Created by Andreas on 9/25/21.
//

import SwiftUI

struct QuizView: View {
    @State var quiz: Quiz
    @State var currentQuestion = 0
    @State var takingQuiz = false
    var body: some View {
        TabView(selection: $currentQuestion) {
            if #available(iOS 15.0, *) {
                ForEach(Array($quiz.questions.enumerated()), id: \.offset) { i, $question in
                    QuestionsView(takingQuiz: $takingQuiz, quiz: $quiz, question: $question, currentQuestion: $currentQuestion)
                        .tag(i)
                }
            } else {
                // Fallback on earlier versions
            }
    }
    }
}

