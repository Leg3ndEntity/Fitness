//
//  HealthKitManager.swift
//  Fitness
//
//  Created by Simone Sarnataro on 17/11/23.
//

import Foundation
import HealthKit


extension Double {
    func fString() -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}

class HealthKitManager: NSObject, ObservableObject {
    let healthStore = HKHealthStore()
    
    @Published var energyBurnedValue: Int = 0
    @Published var exercisevalue: Int = 0
    @Published var standValue: Int = 0
    @Published var stepValue: Int = 0
    @Published var walkDistance: Int = 0
    
    //    init(){
    //        let steps = HKQuantityType(.stepCount)
    //        let calories = HKQuantityType(.activeEnergyBurned)
    //        let workout = HKQuantityType(.appleExerciseTime)
    //        let stand = HKQuantityType(.appleStandTime)
    //        let healthType: Set = [steps, calories, workout, stand]
    //
    //        Task{
    //            do{
    //                try await healthStore.requestAuthorization(toShare: [], read: healthType)
    //                startEnergyQuery(quantityTypeIdentifier: .activeEnergyBurned)
    //                startExerciseQuery(quantityTypeIdentifier: .appleExerciseTime)
    //                startStandQuery(quantityTypeIdentifier: .appleStandTime)
    //                startStepQuery(quantityTypeIdentifier: .stepCount)
    //            } catch {
    //                print("error fetching health data")
    //            }
    //        }
    //    }
    
    
    func requestAuthorization() {
        let typesToRead: Set = [
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKQuantityType.quantityType(forIdentifier: .appleExerciseTime)!,
            HKQuantityType.quantityType(forIdentifier: .appleStandTime)!,
            HKQuantityType.quantityType(forIdentifier: .stepCount)!,
            HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKObjectType.activitySummaryType()
        ]
        
        healthStore.requestAuthorization(toShare: nil, read: typesToRead, completion: { (success, error) in
            if success {
                print("Requested authorization")
            } else {
                // do something if error
                print("Failed to request authorization: \(error?.localizedDescription ?? "")")
            }
        })
    }
    
    func startEnergyQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
        let energyType = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let now = Date()
        let predicate = HKQuery.predicateForSamples(withStart: today, end: now, options: .strictStartDate)
        let statisticsOptions: HKStatisticsOptions = .cumulativeSum
        
        let query = HKStatisticsQuery(quantityType: energyType, quantitySamplePredicate: predicate, options: statisticsOptions) { (query, result, error) in
            if let result = result, let sumQuantity = result.sumQuantity() {
                let totalEnergyBurned = sumQuantity.doubleValue(for: HKUnit.kilocalorie())
                
                DispatchQueue.main.async {
                    print("calories: \(totalEnergyBurned)")
                    self.energyBurnedValue = Int(totalEnergyBurned)
                }
            } else {
                print("Failed to fetch total energy burned: \(error?.localizedDescription ?? "")")
            }
        }
        
        healthStore.execute(query)
    }
    
    func startExerciseQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
        let energyType = HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let now = Date()
        let predicate = HKQuery.predicateForSamples(withStart: today, end: now, options: .strictStartDate)
        let statisticsOptions: HKStatisticsOptions = .cumulativeSum
        
        let query = HKStatisticsQuery(quantityType: energyType, quantitySamplePredicate: predicate, options: statisticsOptions) { (query, result, error) in
            if let result = result, let sumQuantity = result.sumQuantity() {
                let totalExerciseTime = sumQuantity.doubleValue(for: HKUnit.minute())
                
                DispatchQueue.main.async {
                    print("exercise time: \(totalExerciseTime)")
                    self.exercisevalue = Int(totalExerciseTime)
                }
            } else {
                print("Failed to fetch total exercise time: \(error?.localizedDescription ?? "")")
            }
        }
        
        healthStore.execute(query)
    }
    
    func startStandQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
        let energyType = HKObjectType.quantityType(forIdentifier: .appleStandTime)!
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let now = Date()
        let predicate = HKQuery.predicateForSamples(withStart: today, end: now, options: .strictStartDate)
        let statisticsOptions: HKStatisticsOptions = .cumulativeSum
        
        let query = HKStatisticsQuery(quantityType: energyType, quantitySamplePredicate: predicate, options: statisticsOptions) { (query, result, error) in
            if let result = result, let sumQuantity = result.sumQuantity() {
                let totalStandTime = sumQuantity.doubleValue(for: HKUnit.minute())
                
                DispatchQueue.main.async {
                    print("stand time: \(totalStandTime)")
                    self.standValue = Int(totalStandTime)
                }
            } else {
                print("Failed to fetch total stand time: \(error?.localizedDescription ?? "")")
            }
        }
        
        healthStore.execute(query)
    }
    
    func startWalkQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
        let energyType = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let now = Date()
        let predicate = HKQuery.predicateForSamples(withStart: today, end: now, options: .strictStartDate)
        let statisticsOptions: HKStatisticsOptions = .cumulativeSum
        
        let query = HKStatisticsQuery(quantityType: energyType, quantitySamplePredicate: predicate, options: statisticsOptions) { (query, result, error) in
            if let result = result, let sumQuantity = result.sumQuantity() {
                let totalWalkTime = sumQuantity.doubleValue(for: HKUnit.meterUnit(with: .kilo))
                
                DispatchQueue.main.async {
                    print("distance: \(totalWalkTime)")
                    self.walkDistance = Int(totalWalkTime)
                }
            } else {
                print("Failed to fetch total walk distance: \(error?.localizedDescription ?? "")")
            }
        }
        
        healthStore.execute(query)
    }
    
    func startStepQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier){
        let energyType = HKObjectType.quantityType(forIdentifier: .stepCount)!
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let now = Date()
        let predicate = HKQuery.predicateForSamples(withStart: today, end: now, options: .strictStartDate)
        let statisticsOptions: HKStatisticsOptions = .cumulativeSum
        
        let query = HKStatisticsQuery(quantityType: energyType, quantitySamplePredicate: predicate, options: statisticsOptions) { (query, result, error) in
            if let result = result, let sumQuantity = result.sumQuantity() {
                let totalStands = sumQuantity.doubleValue(for: HKUnit.count())
                
                DispatchQueue.main.async {
                    print("staps: \(totalStands)")
                    self.stepValue = Int(totalStands)
                }
            } else {
                print("Failed to fetch total steps: \(error?.localizedDescription ?? "")")
            }
        }
        healthStore.execute(query)
    }
    
    
    
}
