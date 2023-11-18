//
//  HealthManager.swift
//  Fitness
//
//  Created by Simone Sarnataro on 14/11/23.
//

import Foundation
import HealthKit

extension Date{
    static var startOfDay: Date{
        Calendar.current.startOfDay(for: Date())
    }
    
    static var oneMonthAgo: Date{
        let calendar = Calendar.current
        let oneMonth = calendar.date(byAdding: .month, value: -1, to: Date())
        return calendar.startOfDay(for: oneMonth!)
    }
}

extension Double {
    func formattedString() -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}

class HealthManager: ObservableObject{
        
    let healthStore = HKHealthStore()
    @Published var activities: [String: Activity] = [:]
    @Published var oneMonthChartData = [DailyStepView]()
    
    init(){
        let steps = HKQuantityType(.stepCount)
        let calories = HKQuantityType(.activeEnergyBurned)
        let healthType: Set = [steps, calories]
        
        Task{
            do{
                try await healthStore.requestAuthorization(toShare: [], read: healthType)
                fetchTodaySteps()
                fetchTodayCalories()
                fetchPastMonthStepData()
            } catch {
                print("error fetching health data")
            }
        }
    }
    
    func fetchDailySteps(startDate: Date, completion: @escaping([DailyStepView]) -> Void){
        let steps = HKQuantityType(.stepCount)
        let interval = DateComponents(day: 1)
        let archorDate = Calendar.current.startOfDay(for: startDate)
        let query = HKStatisticsCollectionQuery(quantityType: steps, quantitySamplePredicate: nil, anchorDate: archorDate, intervalComponents: interval)
        query.initialResultsHandler = { query, result, error in
            guard let result = result, error == nil else {
                print("error fetching step data")
                completion([])
                return
            }
            var dailySteps = [DailyStepView]()
            //qui fa il conteggio
            result.enumerateStatistics(from: startDate, to: Date()){statistics, stop in
                dailySteps.append(DailyStepView(date: statistics.startDate, stepCount: statistics.sumQuantity()?.doubleValue(for: .count()) ?? 0.00))
            }
            completion(dailySteps)
        }
        healthStore.execute(query)
    }
    
    
    func fetchTodaySteps(){
        let steps = HKQuantityType(.stepCount)
        //let calories = HKQuantityType(.activeEnergyBurned)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate){ _, result, error in
            guard let result = result, let quantity = result.sumQuantity(), error == nil else {
                print("error fetching todays step data")
                return
            }
            let stepCount = quantity.doubleValue(for: .count())
            let activity = Activity(id: 0, title: "Daily Steps", subtitle: "Goal: 10,000", image: "figure.walk", amount: stepCount.formattedString())
            DispatchQueue.main.async{
                self.activities["todaySteps"] = activity
            }
            print(stepCount.formattedString())
        }
        healthStore.execute(query)
    }
    
    func fetchTodayCalories(){
        let calories = HKQuantityType(.activeEnergyBurned)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate){ _, result, error in
            guard let result = result, let quantity = result.sumQuantity(), error == nil else {
                print("error fetching todays calories data")
                return
            }
            let caloriesBurned = quantity.doubleValue(for: .kilocalorie())
            let activity = Activity(id: 1, title: "Daily Calories", subtitle: "Goal: 120", image: "flame", amount: caloriesBurned.formattedString())
            DispatchQueue.main.async{
                self.activities["todayCalories"] = activity
            }
            print(caloriesBurned.formattedString())
        }
        healthStore.execute(query)
    }
    
    
}


//MARK: Chart Data
extension HealthManager{
    
    func fetchPastMonthStepData(){
        fetchDailySteps(startDate: .oneMonthAgo){ dailySteps in
            DispatchQueue.main.async{
                self.oneMonthChartData = dailySteps
            }
        }
    }
}
