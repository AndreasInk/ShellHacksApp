//
//  CourseListView.swift
//  ShellHacksApp
//
//  Created by Andreas on 9/25/21.
//

import SwiftUI
import SFSafeSymbols

struct CourseListView: View {
    

    @StateObject var quizManager: QuizManager
    @State var mode: EditMode = .inactive //< -- Here
    @State var newTag = ""
    @State  var allTags = UserDefaults.standard.stringArray(forKey: "allTags") ?? ["None"]
    
    @State var newCourse = Course(id: UUID().uuidString, title: "", quizzes: [Quiz](), tag: "None", image: SFSymbol.sleep.rawValue)
    @StateObject var ML = MLManager()
      var body: some View {
          NavigationView {
        
          List {
         
             
                  ForEach(Array($quizManager.courses.enumerated()), id: \.offset) { questionIndex, $course in
                      VStack {
                          NavigationLink(destination:  QuizListView(quizManager: quizManager, course: $course)) {
                          HStack {
                          VStack {
                              
                              HStack {
                                  Text(course.title)
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
                                  //.foregroundColor(!quiz.picked.isEmpty ? quiz.correct == question.picked ? Color(.green).opacity(0.6) : Color(.red).opacity(0.6) : Color.Primary.opacity(0.2))
                          }
                          
                      }
                          HStack {
                              Menu(course.tag) {
                                  ForEach(allTags, id: \.self) { tag in
                                      Button(tag, action: {
                                          quizManager.courses[questionIndex].tag = tag
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
                          Button(role: .destructive) {
                              quizManager.courses.remove(at: questionIndex)
                                                  } label: {
                                                      Label("Delete", systemSymbol: .trash)
                                                  }
                                              }
                      .swipeActions(edge: .trailing) {
                          Button(role: .none){
                              quizManager.editCourse.toggle()
                             
                                                  } label: {
                                                      Label("Edit", systemSymbol: .pencil)
                                                  }
                                              }
                      .sheet(isPresented: $quizManager.editCourse) {
                          EditCourseView(quizManager: quizManager, course: $course, toggledIndex: questionIndex)
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
          .sheet(isPresented: $quizManager.addCourse) {
              EditCourseView(quizManager: quizManager, course: $newCourse, toggledIndex: 0)
          }
          .navigationBarItems(leading: Button(action: {
              quizManager.quiz.questions.append(Question(id: UUID().uuidString, questionStr: "", a: "", b: "", c: "", correct: "", picked: ""))
              quizManager.addCourse.toggle()
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
                  }
                      
          
          
         
              .background(Color.Card)
              .edgesIgnoringSafeArea(.all)
              
      
         
         
          
          }
          
      
    func deleteItems(at offsets: IndexSet) {
        quizManager.quiz.questions.remove(atOffsets: offsets)
    }
}
