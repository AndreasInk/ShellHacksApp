//
//  QuestionsView.swift
//  ShellHacksApp
//
//  Created by Andreas on 9/25/21.
//

import SwiftUI

struct QuestionsView: View {
    @Binding var question: Question
    var body: some View {
        VStack {
            ChoiceView(choice: $question.a, question: $question)
            ChoiceView(choice: $question.b, question: $question)
            ChoiceView(choice: $question.c, question: $question)
        }
    }
}
struct ChoiceView: View {
    @Binding var choice: String
    @Binding var question: Question
    var body: some View {
        
        Button(action: {
            question.picked = choice
        }) {
            
            Text(choice)
            
        } .buttonStyle(CurvedGradientButtonStyle(button: ButtonData(id: UUID().uuidString, type: .Outline, gradient: .Primary)))
            .disabled(question.picked.isEmpty ? true : false)
    }
}
