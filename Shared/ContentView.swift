//
//  ContentView.swift
//  Shared
//
//  Created by Andreas on 9/24/21.
//

import SwiftUI
import SFSafeSymbols

struct ContentView: View {
    @State var loading = true
    @State var onboardingFinished = UserDefaults.standard.bool(forKey: "onboardingFinished")
   
    var body: some View {
       
        ZStack {
            if !onboardingFinished {
                OnboardingView(onboardingFinished: $onboardingFinished)
                .transition(.opacity)
            } else {
                //HomeView()
                QuizView()
            }
        
        if loading {
        LoadingView()
                .onAppear() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                        withAnimation(.easeOut(duration: 1.5)) {
                    loading = false
                        }
                    }
             
                }}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
