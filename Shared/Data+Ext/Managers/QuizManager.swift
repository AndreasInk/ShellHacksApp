//
//  QuizManager.swift
//  ShellHacksApp
//
//  Created by Andreas on 9/25/21.
//

import SwiftUI
import Combine
import SFSafeSymbols

class QuizManager: ObservableObject {
    @Published var queued = false
    @Published var quiz = Quiz(id: "", questions: [Question](), tag: "", image: SFSymbol.sleep.rawValue)
    
    @Published var takingQuiz: Bool = true
    @Published var choice: String = ""
    @Published var question: Question?
    @Published var currentQuestion: Int = 0
    
    init() {
        
    }
//    func getQuiz(quiz: Quiz) -> Quiz {
//        var mutableQuiz = quiz
//        let url = URL(string: "http://armenu.hopto.org:8000/\(quiz.id)")!
//
//         var cancellable: AnyCancellable?
//
//         cancellable = URLSession.shared.dataTaskPublisher(for: url)
//        .map { $0.data }
//        .decode(type: Quiz.self, decoder: JSONDecoder())
//        .replaceError(with: Quiz(id: "", questions: [Question](), tags: [String](), image: SFSymbol.sleep.rawValue))
//        .eraseToAnyPublisher()
//        .sink(receiveValue: { quiz in
//            mutableQuiz = quiz
//        })
//
//        cancellable?.cancel()
//        return mutableQuiz
//    }
    func getQuiz(apiInput: APIInput) -> AnyPublisher<Quiz, Error> {
      
        let url = URL(string: "http://armenu.hopto.org:8000/?APIInput=" + ("\(apiInput)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""))!

      var urlRequest = URLRequest(url: url)
      urlRequest.httpMethod = "POST"

      return URLSession.shared
        .dataTaskPublisher(for: urlRequest)
        .receive(on: DispatchQueue.main)
        .map(\.data)
        .print()
        .decode(
          type: Quiz.self,
          decoder: JSONDecoder())
        .eraseToAnyPublisher()
    }
  
   
}
