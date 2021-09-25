//
//  ContentView.swift
//  Shared
//
//  Created by Andreas on 9/24/21.
//

import SwiftUI
import SFSafeSymbols

struct ContentView: View {
    @State var loading = false
    @State var onboardingFinished = UserDefaults.standard.bool(forKey: "onboardingFinished")
    @State var questions = [Question(id: UUID().uuidString, questionStr: "Hello", a: "Hello World", b: "Hello W0rld", c: "Hell0 World", correct: "Hello", picked: ""), Question(id: UUID().uuidString, questionStr: "Hello", a: "Hello World", b: "Hello W0rld", c: "Hell0 World", correct: "Hello", picked: "")]
    var body: some View {
        if loading {
        LoadingView()
                .onAppear() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                        withAnimation(.easeOut(duration: 1.5)) {
                    loading = false
                        }
                    }
                }
        } else {
            if !onboardingFinished {
                OnboardingView(onboardingFinished: $onboardingFinished)
                .transition(.opacity)
            } else {
                //HomeView()
                QuizView(quiz: Quiz(id: UUID().uuidString, questions: questions, tags: [String](), image: SFSymbol.sleep.rawValue))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
