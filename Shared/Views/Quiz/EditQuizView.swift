//
//  EditQuizView.swift
//  ShellHacksApp
//
//  Created by Andreas on 9/25/21.
//

import SwiftUI
import SFSafeSymbols

struct EditQuizView: View {
    @ObservedObject var quizManager: QuizManager
    @Binding var course: Course
    @Binding var quiz: Quiz
    @State var openQuestions = [Int]()
    @State var toggledIndex: Int = 0
    var body: some View {
        ScrollView(showsIndicators: false) {
            ScrollViewReader { proxy in
        VStack {
            Button(action: {
                quizManager.showSFSymbols.toggle()
            }) {
              
                Image(systemSymbol: SFSymbol(rawValue: quiz.image) ?? .sleep)
            .foregroundColor(.Primary)
            .font(.custom("Poppins-Bold", size: 100, relativeTo: .headline))
            }
            ForEach(Array($quizManager.quiz.questions.enumerated()), id: \.offset) { questionIndex, $question in
                Button(action: {
                    if !openQuestions.contains(questionIndex) {
                        withAnimation(.spring()) {
                        openQuestions.append(questionIndex)
                        }
                    } else {
                        if let index = openQuestions.firstIndex(of: questionIndex) {
                            withAnimation(.spring()) {
                        openQuestions.remove(at: index)
                            }
                        }
                    }
                }) {
                    
                HStack {
                Text("\(questionIndex + 1)) Question")
                    .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                    Spacer()
                    Image(systemSymbol: openQuestions.contains(questionIndex) ? .chevronDown : .chevronRight)
                        .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                }
                .onAppear() {
                    proxy.scrollTo(toggledIndex)
                }
                }
               
                TextField("Question", text: $question.questionStr)
                    .font(.custom("Poppins", size: 16, relativeTo: .headline))
                if  openQuestions.contains(questionIndex) {
                HStack {
                Text("A")
                    .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                    Spacer()
                }
                TextField("A", text: $question.a)
                    .font(.custom("Poppins", size: 16, relativeTo: .headline))
                HStack {
                Text("B")
                    .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                    Spacer()
                }
                TextField("B", text: $question.b)
                    .font(.custom("Poppins", size: 16, relativeTo: .headline))
                HStack {
                Text("C")
                    .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                    Spacer()
                }
                TextField("C", text: $question.c)
                    .font(.custom("Poppins", size: 16, relativeTo: .headline))
           
                HStack {
                Text("Correct")
                    .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                    Spacer()
                }
                TextField("Correct", text: $question.correct)
                    .font(.custom("Poppins", size: 16, relativeTo: .headline))
                }
                Divider()
                    .padding(.vertical)
            } .textFieldStyle(CurvedTextFieldStyle())
            Spacer()
           
        Button(action: {
            if quizManager.addQuiz  {
                course.quizzes.append(quiz)
            }
            quizManager.editQuiz = false
            quizManager.addQuiz = false
        }) {
            Text("Save")
                .frame(width: 220)
        } .buttonStyle(CurvedGradientButtonStyle(button: ButtonData(id: UUID().uuidString, type: .Gradient, gradient: .Primary)))
                .padding(.vertical)
    
               
        } .padding()
            }
        }
    }
}

