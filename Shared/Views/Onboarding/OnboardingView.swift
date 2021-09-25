//
//  OnboardingView.swift
//  ShellHacksApp
//
//  Created by Andreas on 9/25/21.
//

import SwiftUI

struct OnboardingView: View {
    @State var onboarding = [Onboarding(id: UUID().uuidString, tag: 0, title: "Welcome to RememBear.", text: "It's a long journey you've set out on to meet your educational goals, and we want to help you retain what you've learned.", image: Image("person")), Onboarding(id: UUID().uuidString, tag: 2, title: "Acquisition of Information", text: "The acquisition phase relies heavily of the collection of data. In our case, we encourage you to record lectures, scan textbook pages and notes into the app, so that RememBear can turn this information into learning material for you.", image: Image("logo")),Onboarding(id: UUID().uuidString, tag: 2, title: "Learning the Material", text: "Learning the material with RememBear allows you to work with personalized questions created from the material that you uploaded. No more flashcards, and no more pretending like you didn't write these questions. We wanted to replicate the \"unknown\" factor of tests.", image: Image("logo")), Onboarding(id: UUID().uuidString, tag: 2, title: "Long-Term Retention", text: "Retention is probably the hardest but most crucial piece of the process. Research has shown that listening to the same audio while learning information as when attempting to recall it, leads to a higher rate of retention. We want to help you leverage this fact by offering a wide range of audio to listen to while studying, and for you to \"learn as you sleep.\"", image: Image("logo")),  Onboarding(id: "Login", tag: 1, title: "Hello World", text: "mskdjkjskmdksdskjdksddsdslskdlds", image: Image("data") )]
    
    @Binding var onboardingFinished: Bool
    @State var currentSlide = 0
    var body: some View {
        GeometryReader { geo in
        ZStack {
            
        TabView(selection: $currentSlide) {
            ForEach(Array(onboarding.enumerated()), id: \.offset) { i, onboarding in
            if onboarding.id == "Login" {
                LoginView()
                    .tag(i)
            } else {
            ZStack {
                
                OnboardingDetailsView(onboarding: onboarding, currentSlide: $currentSlide, onboardings: $onboarding, onboardingFinished: $onboardingFinished)
              
               
            }  .tag(i)
            }
        }
        
        } .tabViewStyle(PageTabViewStyle())
            if currentSlide != onboarding.count - 1 {
            VStack {
                Spacer(minLength: geo.size.height/3)
                ZStack {
                    SceneView(options: [])
                    VStack {
                        Spacer(minLength: geo.size.height/3)
                Button(action: {
                    
                    if self.onboarding.indices.contains(currentSlide + 1) {
                    currentSlide += 1
                        if currentSlide == 1 {
                            animationType = .PointBackwards
                        } else if currentSlide == 1 {
                            animationType = .ThumbsUp
                        }
                    } else {
                        UserDefaults.standard.set(true, forKey: "onboardingFinished")
                        onboardingFinished = true
                    }
                }) {
                   
                    Text(self.onboarding.indices.contains(currentSlide + 1) ? "Next" : "Explore")
                        
                    
                } .buttonStyle(CurvedBorderButtonStyle(button: ButtonData(id: UUID().uuidString, type: .Outline, gradient: .Primary)))
                    .padding(.bottom)
                    }
            }
            }
        }
        }
    
        }
    }
}

struct OnboardingDetailsView: View {
    @State var onboarding: Onboarding
    @Binding var currentSlide: Int
    @Binding var onboardings: [Onboarding]
    @Binding var onboardingFinished: Bool
    var body: some View {
       
        GeometryReader { geo in
            
            ZStack {
                ScrollView {
                VStack {
                LinearGradient.Dark
                        .ignoresSafeArea()
                        .frame(height: geo.size.height/1.8)
                       
                
              
                
                
                
                    
               
                    
               
                    
                        HStack {
                            Spacer()
                Text(onboarding.title)
                    .font(.custom("Poppins-Bold", size: 24, relativeTo: .headline))
                    .multilineTextAlignment(.trailing)
                    .padding()
                    .padding(.bottom)
                        }
                            HStack {
                                Spacer(minLength: geo.size.width/3)
                                
                Text(onboarding.text)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.custom("Poppins", size: 10, relativeTo: .subheadline))
                    .multilineTextAlignment(.trailing)
                    .padding()
                            
                            } .padding(.leading)
                
                        .padding(.bottom, geo.size.height/1.3)
            }
                VStack {
                   
                onboarding.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.height/3, height: geo.size.height/3)
                   // .clipShape(Circle())
                    .padding()
                    Spacer(minLength: geo.size.height/1.8)
                } .padding(.top, geo.size.height/4)
         
          //  }
    }
            }
        }
    }
}

