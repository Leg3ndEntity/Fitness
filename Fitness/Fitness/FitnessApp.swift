//
//  FitnessApp.swift
//  Fitness
//
//  Created by Simone Sarnataro on 14/11/23.
//

import SwiftUI

@main
struct FitnessApp: App {
    
     @StateObject var manager = HealthManager()
    
    var body: some Scene {
        WindowGroup {
//            ContentView(activity: Activity(id: 0, title: "Daily Steps", subtitle: "Goal: 10,000", amount: "6,453"))
//                .environmentObject(manager)
            MainPageView()
                .environmentObject(manager)
        }
    }
}
