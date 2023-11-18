//
//  FitnessApp.swift
//  Fitness
//
//  Created by Simone Sarnataro on 14/11/23.
//

import SwiftUI
import SwiftData

@main
struct FitnessApp: App {
    
    @StateObject var healthKitManager = HealthKitManager()
    @StateObject var manager = HealthManager()
    var body: some Scene {
        WindowGroup {
            MainPageView()
                .environmentObject(healthKitManager)
                .preferredColorScheme(.dark)
                .onAppear{
                    healthKitManager.startEnergyQuery(quantityTypeIdentifier: .activeEnergyBurned)
//                    healthKitManager.startExerciseQuery(quantityTypeIdentifier: .appleExerciseTime)
//                    healthKitManager.startStandQuery(quantityTypeIdentifier: .appleStandTime)
                    healthKitManager.startStepQuery(quantityTypeIdentifier: .stepCount)
                    healthKitManager.startWalkQuery(quantityTypeIdentifier: .distanceWalkingRunning)
                }
        }
        .modelContainer(for: User.self)
    }
}

