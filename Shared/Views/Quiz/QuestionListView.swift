//
//  QuestionListView.swift
//  ShellHacksApp
//
//  Created by Andreas on 9/25/21.
//

import SwiftUI

struct QuestionsListView: View {
    

    @StateObject var quizManager: QuizManager
      var body: some View {
          NavigationView {
          ZStack {
          List {
          ScrollView {
              VStack(alignment: .leading) {
                  ForEach(Array(quizManager.quiz.questions.enumerated()), id: \.offset) { questionIndex, question in
                      NavigationLink(destination:  QuestionsView(quizManager: quizManager, question: $quizManager.quiz.questions[quizManager.currentQuestion])) {
                          HStack {
                          VStack {
                              
                              HStack {
                              Text(question.questionStr)
                                  .font(.custom("Poppins-Bold", size: 18))
                                  .foregroundColor(.Dark)
                              .multilineTextAlignment(.leading)
                              .fixedSize(horizontal: false, vertical: true)
                              .padding(.trailing)
                                  Spacer()
                              }
                             
                              HStack {
                              Text(question.tag ?? "None")
                                      .font(.custom("Poppins-Bold", size: 12))
                                      .multilineTextAlignment(.leading)
                                      .foregroundColor(.white)
                                      .padding(5)
                                      .background(Color.Secondary)
                                      .cornerRadius(10)
                                      .padding(.trailing)
                              
                              Spacer()
                              }
                          } .padding()
                              Spacer()
                              Circle()
                                  .frame(width: 25, height: 25)
                                  .foregroundColor(!question.picked.isEmpty ? question.correct == question.picked ? Color(.green).opacity(0.6) : Color(.red).opacity(0.6) : Color.Primary.opacity(0.2))
                          }
                      }
                      Button(action: {
                          quizManager.currentQuestion = questionIndex
                         
                      }) {
                         
                  }
                     
                  }
                Spacer()
              }
              

          }
              
          }
          .padding()
              .background(Color.Card)
              .edgesIgnoringSafeArea(.all)
      }
          }
  }
}
