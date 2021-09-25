//
//  QuizView.swift
//  ShellHacksApp
//
//  Created by Andreas on 9/25/21.
//

import SwiftUI

struct QuizView: View {
    @StateObject var quizManager = QuizManager()
    @State var currentQuestion = 0
    @State var takingQuiz = false
    var body: some View {
        TabView(selection: $currentQuestion) {
            if #available(iOS 15.0, *) {
                ForEach(Array($quizManager.quiz.questions.enumerated()), id: \.offset) { i, $question in
                    QuestionsView(quizManager: quizManager, question: $question)
                        .tag(i)
                }
            } else {
                // Fallback on earlier versions
            }
    }
    }
}

