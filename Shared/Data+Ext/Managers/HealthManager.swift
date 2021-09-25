//
//  HealthManager.swift
//  ShellHacksApp
//
//  Created by Andreas on 9/25/21.
//

import SwiftUI
import HealthKit
import Combine
import HKCombine

class HealthManager: ObservableObject {
   var cancellableBag2 = Set<AnyCancellable>()
    @Published var healthStore = HKHealthStore()
    let heartrateQuantity = HKUnit(from: "count/min")
    var music = MusicManager.shared
    let timer = Timer.publish(every: 1800, on: .main, in: .common).autoconnect()
    init() {
        backgroundDelivery()
        UIDevice.current.isProximityMonitoringEnabled = true
    }
    func backgroundDelivery() {
         DispatchQueue.main.async {
 
             let readData = Set([
 //                    HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!,
                // HKCategoryType(.sleepAnalysis),
                 HKObjectType.quantityType(forIdentifier: .heartRate)!,
                // HKObjectType.quantityType(forIdentifier: .oxygenSaturation)!,
                 HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
                 HKObjectType.quantityType(forIdentifier: .respiratoryRate)!
             ])
 
             self.healthStore.requestAuthorization(toShare: [], read: readData) { (success, error) in
 
                 if success {
         let readType2 = HKObjectType.quantityType(forIdentifier: .heartRate)
 
             if let readType2 = readType2 {
                 //if self.healthStore.authorizationStatus(for: readType2) == .sharingAuthorized {
                 self.healthStore.enableBackgroundDelivery(for: readType2, frequency: .immediate) { success, error in
             if !success {
                 print("Error enabling background delivery for type \(readType2.identifier): \(error.debugDescription)")
             } else {
                 print(1)
                
                 self.healthStore.statistic(for:  HKQuantityType.init(.respiratoryRate), with: .mostRecent,from:Date().addingTimeInterval(TimeInterval(-60)), to: Date().addingTimeInterval(TimeInterval(60)))
                         .receive(on: DispatchQueue.main)
                         .sink(receiveCompletion: { subscription in
                             
                         }, receiveValue: { samples in
                             
                             // If there's smaples then add the sample to healthData
                             if (samples.mostRecentQuantity()?.doubleValue(for: self.heartrateQuantity) ?? 20) < 16 {
                                 for artist in self.music.getArtists().map({$0.items}) {
                                     let filteredToComposer = artist.filter{$0.artist == "Lone"}
                                     if let artist = filteredToComposer.first {
                                         self.music.playArtistsSongs(artist: artist)
                                 } else {
                                     print("OOOOF")
                                 }
                             }
                             }
                             
                             // Does something, lol
                         }).store(in: &self.cancellableBag2)
                 
//                 healthStore
//                     .get(sample: HKSampleType.quantityType(forIdentifier: .respiratoryRate)!, start:Date().addingTimeInterval(TimeInterval(-60)), end: Date().addingTimeInterval(TimeInterval(60)))
//                             .receive(on: DispatchQueue.main)
//                             .sink(receiveCompletion: { subscription in
//
//                             }, receiveValue: { samples in
//
//                                 // If there's smaples then add the sample to healthData
//                                 if samples.count > 0 {
//                                 self.healthData.append(HealthData(id: UUID().uuidString, type: .Health, title: HKSampleType.quantityType(forIdentifier: .respiratoryRate)?.identifier ?? "", text: "", date: Date(), data: self.average(numbers: samples.map{$0.quantity.doubleValue(for: self.heartrateQuantity)})))
//                                 }
//                             // Does something, lol
//                             }).store(in: &cancellableBag2)
             }
             }
                 }
         }
             }
 
         }
     }
}
