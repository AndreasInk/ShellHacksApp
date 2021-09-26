//
//  EditCourseView.swift
//  ShellHacksApp
//
//  Created by Andreas on 9/26/21.
//

import SwiftUI
import SFSafeSymbols

struct EditCourseView: View {
    @ObservedObject var quizManager: QuizManager
    @Binding var course: Course
    @State var openQuestions = [Int]()
    @State var toggledIndex: Int = 0
    var body: some View {
        ScrollView(showsIndicators: false) {
            ScrollViewReader { proxy in
        VStack {
            Button(action: {
                quizManager.showSFSymbols.toggle()
            }) {
              
                Image(systemSymbol: SFSymbol(rawValue: course.image) ?? .sleep)
            .foregroundColor(.Primary)
            .font(.custom("Poppins-Bold", size: 100, relativeTo: .headline))
            }
            HStack {
            Text("Course Name")
                .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
                Spacer()
            }
            TextField("Course Name", text: $course.title)
                .font(.custom("Poppins", size: 16, relativeTo: .headline))
            
             .textFieldStyle(CurvedTextFieldStyle())
            Spacer()
           
        Button(action: {
            if quizManager.addCourse  {
            quizManager.courses.append(course)
            }
            quizManager.editCourse = false
            quizManager.addCourse = false
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

