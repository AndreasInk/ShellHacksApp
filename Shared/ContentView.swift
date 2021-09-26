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
    @State var onboardingFinished =  UserDefaults.standard.bool(forKey: "onboardingFinished")
   @StateObject var quizManager = QuizManager()
    var body: some View {
       
        ZStack {
            if !onboardingFinished {
                OnboardingView(onboardingFinished: $onboardingFinished)
                .transition(.opacity)
            } else {
               // NightView()
                //HomeView()
                TabView {
                QuizView(quizManager: quizManager)
                        .tabItem {
                            Label("Quiz", systemSymbol: .doc)
                                        }
                    NightView()
                        .tabItem {
                            Label("Sleep", systemSymbol: .moon)
                                        }
                           
                }
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
        .onAppear() {
            let url = self.getDocumentsDirectory().appendingPathComponent("courses.txt")
            do {

                let input = try String(contentsOf: url)


                let jsonData = Data(input.utf8)

                    let decoder = JSONDecoder()


                        let note = try decoder.decode([Course].self, from: jsonData)
                quizManager.courses = note




                    } catch {
                    }
           
            

           // process()
                 
        }
        .onChange(of: quizManager.courses) { newValue in
           
           let encoder = JSONEncoder()
          
            if let encoded = try? encoder.encode(quizManager.courses) {
               if let json = String(data: encoded, encoding: .utf8) {
                   do {
                       let url = self.getDocumentsDirectory().appendingPathComponent("courses.txt")
                       try json.write(to: url, atomically: false, encoding: String.Encoding.utf8)
                       
                   } catch {
                       print("erorr")
                   }
//                    let newItem = Item(context: managedObjectContext)
//                    newItem.jsonDataString = json
                  
               }
             
           }
        }
    }
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
