//
//  QuestionsView.swift
//  ShellHacksApp
//
//  Created by Andreas on 9/25/21.
//

import SwiftUI

struct QuestionsView: View {
    @ObservedObject var quizManager: QuizManager
    @Binding var question: Question
    var body: some View {
        VStack {
           
            Text(question.questionStr)
                .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
            ChoiceView(quizManager: quizManager, choice: question.a, question: $question)
                ChoiceView(quizManager: quizManager, choice: question.b, question: $question)
                ChoiceView(quizManager: quizManager, choice: question.c, question: $question)
            
        
        }
    }
}
struct ChoiceView: View {
    @ObservedObject var quizManager: QuizManager
    @State var choice: String
    @Binding var question: Question
    var body: some View {
        
        Button(action: {
            question.picked = choice
            if quizManager.quiz.questions.indices.contains(quizManager.currentQuestion + 1) {
                quizManager.currentQuestion += 1
            } else {
                quizManager.done = true
            }
            
        }) {
            
            Text(choice)
            
        } .buttonStyle(CurvedBorderButtonStyle(button: ButtonData(id: UUID().uuidString, type: .Outline, gradient: .Primary)))
           // .disabled(question.picked.isEmpty ? true : false)
            .padding()
    }
}
