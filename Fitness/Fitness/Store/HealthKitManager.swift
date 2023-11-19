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

struct HourlyCalorieView: Identifiable {
    let id = UUID()
    let date: Date
    let calorieCount: Double
}

class HealthKitManager: NSObject, ObservableObject {
    let healthStore = HKHealthStore()
    
    @Published var hourlyCalorieData: [HourlyCalorieView] = []
    @Published var energyBurnedValue: Int = 0
    @Published var exercisevalue: Int = 0
    @Published var standValue: Int = 0
    @Published var stepValue: Int = 0
    @Published var walkDistance: Double = 0.0
    
    func requestAuthorization() {
        let typesToRead: Set = [
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
            //            HKQuantityType.quantityType(forIdentifier: .appleExerciseTime)!,
            //            HKQuantityType.quantityType(forIdentifier: .appleStandTime)!,
            HKQuantityType.quantityType(forIdentifier: .stepCount)!,
            HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKObjectType.activitySummaryType()
        ]
        
        healthStore.requestAuthorization(toShare: nil, read: typesToRead, completion: { (success, error) in
            if success {
                print("Requested authorization")
            } else {
                print("Failed to request authorization: \(error?.localizedDescription ?? "")")
            }
        })
    }
    
    func fetchHourlyCalories(completion: @escaping ([HourlyCalorieView]) -> Void) {
        let calories = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        
        let calendar = Calendar.current
        let currentDate = Date()
        let startDate = calendar.startOfDay(for: currentDate)
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        
        let interval = DateComponents(hour: 1)
        let anchorDate = calendar.startOfDay(for: startDate)
        
        let query = HKStatisticsCollectionQuery(quantityType: calories, quantitySamplePredicate: nil, anchorDate: anchorDate, intervalComponents: interval)
        
        query.initialResultsHandler = { query, result, error in
            guard let result = result, error == nil else {
                print("Error fetching hourly calorie data")
                completion([])
                return
            }
            
            var hourlyCalories = [HourlyCalorieView]()
            
            result.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
                let endDate = statistics.endDate
                let caloriesValue = statistics.sumQuantity()?.doubleValue(for: .kilocalorie()) ?? 0.0
                hourlyCalories.append(HourlyCalorieView(date: endDate, calorieCount: caloriesValue))
                
                print("Date: \(endDate), Calories: \(caloriesValue)")
            }
            
            completion(hourlyCalories)
        }
        
        healthStore.execute(query)
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
                    self.walkDistance = Double(totalWalkTime)
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
