//
//  MLManager.swift
//  ShellHacksApp
//
//  Created by Andreas on 9/25/21.
//

import SwiftUI
import CoreML
import TabularData
import CreateML
class MLManager: ObservableObject {

    func tagQuestions(quiz: Quiz) -> Quiz {
      var mutableQuiz = quiz
        DispatchQueue.global(qos: .userInitiated).async {
        do {
            
            print("tagging")
            
            
            let filteredtagClassification = quiz.questions.filter { data in
                return data.tag != "none" && data.tag != ""
            }
           if filteredtagClassification.count > 2 {
               let url = self.getDocumentsDirectory().appendingPathComponent("tags.json")
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(filteredtagClassification) {
                if let json = String(data: encoded, encoding: .utf8) {
                  
                    do {
                       
                        try json.write(to: url, atomically: false, encoding: String.Encoding.utf8)
                        
                    } catch {
                        print("erorr")
                    }
                }
                
                
            }
            let data = try MLDataTable(contentsOf: url)
            
           // let (trainingData, testingData) = data.randomSplit(by: 0.8, seed: 5)
            
            let sentimentClassifier = try MLTextClassifier(trainingData: data,
                                                            textColumn: "text",
                                                           labelColumn: "tag")
            print(sentimentClassifier.trainingMetrics)
               let questions = filteredtagClassification
               var allQuestions = [Question]()
               for q in questions {
                   allQuestions.append(q)
               }
               let predictions = try sentimentClassifier.predictions(from: allQuestions.map{$0.questionStr})
               //taggedNote.taggedText = []
            for index in predictions.indices {
                if predictions[index] != "none" {
                    print(predictions[index])
                    mutableQuiz.tag = predictions[index]
                   
                   // aggedNote.taggedText.append(TaggedText(id: UUID().uuidString, text: note.text, tag: predictions[index]))
            }
            }
//            let dataForTesting = ["Who is Andreas?", "Who is Eliot?", "Why is Eliot?", "Where is Eliot?"]
//            print(try sentimentClassifier.predictions(from: dataForTesting))
           }
        } catch {
            //print(error.localizedDescription)
        }
    
        }
        return mutableQuiz
    }
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}


