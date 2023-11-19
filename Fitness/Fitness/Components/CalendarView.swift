//
//  CalendarView.swift
//  Fitness
//
//  Created by Simone Sarnataro on 18/11/23.
//

import Foundation
import SwiftUI

struct CalendarView: View {
    
    let currentDateTime = Date()
    @State var daySelector: Bool = false
    func formattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
    var body: some View {
        
        @State var day = formattedDate(date: currentDateTime)
        if day == "Sunday"{
            return AnyView(Rectangle())
        } else {
            return AnyView(Text("Not Friday"))
        }
        
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
                Circle()
                    .frame(width: 22, height: 22, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 79)
                    .foregroundColor(.ringColor1)
                Text("F")
                    .fontWeight(.bold)
                    .padding(.bottom, 80)
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
