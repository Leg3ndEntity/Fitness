//
//  ChartView.swift
//  Fitness
//
//  Created by Simone Sarnataro on 14/11/23.
//

import SwiftUI
import Charts

struct DailyStepView: Identifiable{
    let id = UUID()
    let date: Date
    let stepCount: Double
}

struct ChartView: View {
    @EnvironmentObject var manager: HealthManager
    var body: some View {
        VStack{
            Chart {
                ForEach(manager.oneMonthChartData){ daily in
                    BarMark(x: .value(daily.date.formatted(), daily.date, unit: .day), y: .value("Steps", daily.stepCount))
                }
            }.padding(.horizontal, -2)
                .frame(height: 125)
                .foregroundColor(.red)
        }
    }
}

#Preview {
    ChartView()
        .environmentObject(HealthManager())
}
