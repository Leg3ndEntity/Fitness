//
//  CalendarView.swift
//  Fitness
//
//  Created by Simone Sarnataro on 18/11/23.
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        HStack(spacing: 0){
            ZStack {
                Text("M")
                    .padding(.bottom, 80)
                RingView(percentage: 0.1, backgroundColor: .ringColor2, startColor: .ringColor1, endColor: .ringColor3, thickness: 10)
            }
            ZStack {
                Text("T")
                    .padding(.bottom, 80)
                RingView(percentage: 0.2, backgroundColor: .ringColor2, startColor: .ringColor1, endColor: .ringColor3, thickness: 10)
            }
            ZStack {
                Text("W")
                    .padding(.bottom, 80)
                RingView(percentage: 0.3, backgroundColor: .ringColor2, startColor: .ringColor1, endColor: .ringColor3, thickness: 10)
            }
            ZStack {
                Text("T")
                    .padding(.bottom, 80)
                RingView(percentage: 0.4, backgroundColor: .ringColor2, startColor: .ringColor1, endColor: .ringColor3, thickness: 10)
            }
            ZStack {
                Text("F")
                    .padding(.bottom, 80)
                Circle()
                    .foregroundColor(.ringColor1)
                RingView(percentage: 0.5, backgroundColor: .ringColor2, startColor: .ringColor1, endColor: .ringColor3, thickness: 10)
            }
            ZStack {
                Text("S")
                    .padding(.bottom, 80)
                RingView(percentage: 0.6, backgroundColor: .ringColor2, startColor: .ringColor1, endColor: .ringColor3, thickness: 10)
            }
            ZStack {
                Text("S")
                    .padding(.bottom, 80)
                RingView(percentage: 0.7, backgroundColor: .ringColor2, startColor: .ringColor1, endColor: .ringColor3, thickness: 10)
            }
        }.font(.callout)
    }
}

#Preview {
    CalendarView()
}