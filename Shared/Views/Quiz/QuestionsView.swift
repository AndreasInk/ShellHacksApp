//
//  QuestionsView.swift
//  ShellHacksApp
//
//  Created by Andreas on 9/25/21.
//

import SwiftUI

struct QuestionsView: View {
    @Binding var takingQuiz: Bool
    @Binding var quiz: Quiz
    @Binding var question: Question
    @Binding var currentQuestion: Int
    var body: some View {
        VStack {
            Text(question.questionStr)
                .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
            ChoiceView(takingQuiz: $takingQuiz, quiz: $quiz, choice: $question.a, question: $question, currentQuestion: $currentQuestion)
            ChoiceView(takingQuiz: $takingQuiz,  quiz: $quiz, choice: $question.b, question: $question, currentQuestion: $currentQuestion)
            ChoiceView(takingQuiz: $takingQuiz,  quiz: $quiz, choice: $question.c, question: $question, currentQuestion: $currentQuestion)
        }
    }
}
struct ChoiceView: View {
    @Binding var takingQuiz: Bool
    @Binding var quiz: Quiz
    @Binding var choice: String
    @Binding var question: Question
    @Binding var currentQuestion: Int
    var body: some View {
        
        Button(action: {
            if quiz.questions.indices.contains(currentQuestion + 1) {
            question.picked = choice
            } else {
                takingQuiz = true
            }
            
        }) {
            
            Text(choice)
            
        } .buttonStyle(CurvedGradientButtonStyle(button: ButtonData(id: UUID().uuidString, type: .Outline, gradient: .Primary)))
           // .disabled(question.picked.isEmpty ? true : false)
            .padding()
    }
}
