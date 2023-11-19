//
//  BarChartView.swift
//  Fitness
//
//  Created by Simone Sarnataro on 19/11/23.
//

import SwiftUI
import SwiftUICharts

struct CalorieChartView: View {
    @ObservedObject var healthKitManager: HealthKitManager

    var body: some View {
        VStack {
            BarChartView(data: ChartData(values: [
                ("Energy Burned", Double(healthKitManager.energyBurnedValue)),
                // Aggiungi altri dati come esercizio, stand, ecc.
            ]), title: "Calories", legend: "Daily Total")
                .padding()
        }
    }
}
