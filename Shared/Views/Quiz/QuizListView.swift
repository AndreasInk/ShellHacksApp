//
//  QuizListView.swift
//  ShellHacksApp
//
//  Created by Andreas on 9/25/21.
//

import SwiftUI
import SFSafeSymbols

struct QuizListView: View {
    

    @StateObject var quizManager: QuizManager
    @Binding var course: Course
    @State var mode: EditMode = .inactive //< -- Here
    @State var newTag = ""
    @State  var allTags = UserDefaults.standard.stringArray(forKey: "allTags") ?? ["None"]
    @State var newQuiz = Quiz(id: UUID().uuidString, questions: [Question](), tag: "", image: SFSymbol.sleep.rawValue)
    @StateObject var ML = MLManager()
      var body: some View {
         // NavigationView {
        
          List {
         
             
              ForEach(Array($course.quizzes.enumerated()), id: \.offset) { questionIndex, $quiz in
                      VStack {
                          NavigationLink(destination:  QuestionsListView(quizManager: quizManager, quiz: $quiz, course: $course)) {
                          HStack {
                          VStack {
                              
                              HStack {
                                  Text(quiz.id)
                                  .font(.custom("Poppins-Bold", size: 18))
                                  .foregroundColor(.Dark)
                              .multilineTextAlignment(.leading)
                              .fixedSize(horizontal: false, vertical: true)
                              .padding(.trailing)
                                  Spacer()
                              }
                             
                             
                          } .padding()
                              Spacer()
                              Circle()
                                  .frame(width: 25, height: 25)
                                  //.foregroundColor(!quiz.picked.isEmpty ? quiz.correct == quiz.picked ? Color(.green).opacity(0.6) : Color(.red).opacity(0.6) : Color.Primary.opacity(0.2))
                          }
                          
                      }
                          HStack {
                              Menu(quiz.tag) {
                                  ForEach(allTags, id: \.self) { tag in
                                      Button(tag, action: {
                                          quiz.tag = tag
                                      })
                                     
                                  }
                                  Button("Add Tag", action: {
                                      quizManager.addTag = true
                                  })
                              } .font(.custom("Poppins-Bold", size: 12))
                                  .multilineTextAlignment(.leading)
                                  .foregroundColor(.white)
                                  .padding()
                                  .padding(.horizontal)
                                  .background(Color.Secondary)
                                  .cornerRadius(10)
                                  .padding(.trailing)
                                
                                  
                          
                          Spacer()
                          }
                      } .swipeActions(edge: .trailing) {
                          Button(role: .destructive){
                              course.quizzes.remove(at: questionIndex)
                                                  } label: {
                                                      Label("Delete", systemSymbol: .trash)
                                                  }
                                              }
                      .swipeActions(edge: .trailing) {
                          Button(role: .none){
                              quizManager.editQuiz.toggle()
                                                  } label: {
                                                      Label("Edit", systemSymbol: .pencil)
                                                  }
                                              }
                      .sheet(isPresented: $quizManager.editQuiz) {
                          EditQuizView(quizManager: quizManager, course: $course, quiz: $quizManager.quiz, toggledIndex: questionIndex)
                      }
                      .sheet(isPresented: $quizManager.addTag) {
                          VStack {
                              HStack {
                              Text("Tag Name")
                                  .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                                 Spacer()
                              }
                              TextField("Tag Name", text: $newTag)
                                  .font(.custom("Poppins", size: 16, relativeTo: .headline))
                                  
                                  .textFieldStyle(CurvedTextFieldStyle())
                          
                        Spacer()
                      Button(action: {
                          allTags.append(newTag)
                          newTag = ""
                          UserDefaults.standard.set(allTags, forKey: "allTags")
                          quizManager.addTag = false
                      }) {
                          Text("Save")
                              .frame(width: 220)
                      } .buttonStyle(CurvedGradientButtonStyle(button: ButtonData(id: UUID().uuidString, type: .Gradient, gradient: .Primary)))
                              .padding(.vertical)
                  
                             
                      } .padding()
                          }
                      }
          }
          .sheet(isPresented: $quizManager.addQuiz) {
              EditQuizView(quizManager: quizManager, course: $course, quiz: $newQuiz)
          }
          .navigationBarItems(leading: Button(action: {
              quizManager.quiz.questions.append(Question(id: UUID().uuidString, questionStr: "", a: "", b: "", c: "", correct: "", picked: ""))
              quizManager.addQuiz.toggle()
          }) {
              Image(systemSymbol: .plus)
          }, trailing:
              Button(action: {
              quizManager.quiz = ML.tagQuestions(quiz: quizManager.quiz)
          }) {
              Image(systemSymbol: .tag)
          }
          )
                     
                Spacer()
                //  }
                      
          
          
         
              .background(Color.Card)
              .edgesIgnoringSafeArea(.all)
              
      
         
         
          
          }
          
      
    func deleteItems(at offsets: IndexSet) {
        quizManager.quiz.questions.remove(atOffsets: offsets)
    }
}
