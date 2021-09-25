//
//  OnboardingView.swift
//  ShellHacksApp
//
//  Created by Andreas on 9/25/21.
//

import SwiftUI

struct OnboardingView: View {
    @State var onboarding = [Onboarding(id: UUID().uuidString, tag: 0, title: "Hello World", text: "mskdjkjskmdksdskjdksddsdslskdlds", image: Image("logo")), Onboarding(id: "Login", tag: 1, title: "Hello World", text: "mskdjkjskmdksdskjdksddsdslskdlds", image: Image("logo")), Onboarding(id: UUID().uuidString, tag: 2, title: "Hello World", text: "mskdjkjskmdksdskjdksddsdslskdlds", image: Image("logo"))]
    
    @Binding var onboardingFinished: Bool
    @State var currentSlide = 0
    var body: some View {
       
        ZStack {
            
        TabView(selection: $currentSlide) {
            ForEach(onboarding, id: \.id) { onboarding in
            if onboarding.id == "Login" {
                LoginView()
                    .tag(onboarding.tag)
            } else {
            VStack {
            OnboardingDetailsView(onboarding: onboarding)
                Button(action: {
                    if self.onboarding.indices.contains(currentSlide + 1) {
                    currentSlide += 1
                    } else {
                        UserDefaults.standard.set(true, forKey: "onboardingFinished")
                        onboardingFinished = true
                    }
                }) {
                    Text(self.onboarding.indices.contains(currentSlide + 1) ? "Next" : "Explore")
                } .buttonStyle(CurvedGradientButtonStyle(button: ButtonData(id: UUID().uuidString, type: .Outline, gradient: .Primary)))
                    .padding(.bottom, 100)
            }   .tag(onboarding.tag)
            }
        }
        
        } .tabViewStyle(PageTabViewStyle())
    }
        
    }
}

struct OnboardingDetailsView: View {
    @State var onboarding: Onboarding
    var body: some View {
        GeometryReader { geo in
            
        
        ZStack {
            VStack {
            LinearGradient.Primary
                    .frame(height: geo.size.height/1.8)
                    .ignoresSafeArea(.all, edges: .top)
                Spacer()
            }
            VStack {
                Spacer(minLength: geo.size.height/2.5)
                
                onboarding.image
                    
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .padding()
                    
                Spacer()
                    
                
                Text(onboarding.title)
                    .font(.custom("Poppins-Bold", size: 36, relativeTo: .headline))
                
                Text(onboarding.text)
                    .font(.custom("Poppins", size: 18, relativeTo: .subheadline))
               Spacer()
            }
        }
    }
    }
}

