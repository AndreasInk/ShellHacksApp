//
//  QuizView.swift
//  ShellHacksApp
//
//  Created by Andreas on 9/25/21.
//

import SwiftUI

struct QuizView: View {
    @ObservedObject var quizManager: QuizManager
    @State var takingQuiz = false
    var body: some View {
        
            QuestionsListView(quizManager: quizManager)
       
    }
        
    }


