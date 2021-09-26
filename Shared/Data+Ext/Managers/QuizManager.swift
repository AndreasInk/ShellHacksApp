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
    @Published var done = false
    @Published var addTag = false
    @Published var showSFSymbols = false
    @Published var queued = false
    @Published var editQuiz = false
    @Published var editCourse = false
    @Published var addCourse = false
    @Published var addQuiz = false
    @Published var courses = [Course(id: "a", title: "", quizzes: [Quiz](), tag: "", image: SFSymbol.infinity.rawValue)]
    @Published var quiz = Quiz(id: "", questions: [Question(id: UUID().uuidString, questionStr: "Hello", a: "World", b: "World2", c: "World3", correct: "World", picked: "")], tag: "Yes", image: SFSymbol.sleep.rawValue)
    @Published var takingQuiz: Bool = true
    @Published var choice: String = ""
    @Published var question: Question?
    @Published var currentQuestion: Int = 0
    
    init() {
        courses[0].quizzes.append(quiz)
        print(getQuiz(apiInput: APIInput(text: "Python is an interpreted high-level general-purpose programming language. Its design philosophy emphasizes code readability with its use of significant indentation. Its language constructs as well as its object-oriented approach aim to help programmers write clear, logical code for small and large-scale projects.")))
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
      
        let url = URL(string: "http://armenu.hopto.org:8080/?text=" + ("\(apiInput)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""))!

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
