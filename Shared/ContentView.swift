//
//  ContentView.swift
//  Shared
//
//  Created by Andreas on 9/24/21.
//

import SwiftUI

struct ContentView: View {
    @State var loading = false
    @State var onboardingFinished = UserDefaults.standard.bool(forKey: "onboardingFinished")
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
                HomeView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
