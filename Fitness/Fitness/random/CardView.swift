//
//  ActivityCardView.swift
//  Fitness
//
//  Created by Simone Sarnataro on 14/11/23.
//

import SwiftUI

struct Activity: Identifiable{
    let id: Int
    let title: String
    let subtitle: String
    let image: String
    let amount: String
}

struct CardView: View {
    @State var activity: Activity
    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
            VStack(spacing: 20){
                HStack(alignment: .top){
                    VStack(alignment: .leading, spacing: 5){
                        Text(activity.title)
                        Text(activity.subtitle)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    
                    Image(systemName: "figure.walk")
                        .foregroundColor(.green)
                }
                
                Text(activity.amount)
                    .font(.system(size: 24))
            }
            .padding()
        }
        .cornerRadius(15)
    }
}

struct InfoView: View{
    @State var activity: Activity
    var body: some View{
        let kilo: Double = (Double(activity.amount) ?? 45)*0.725
        //let roundedValue = (kilo * 100).rounded() / 100
        let formattedString = String(format: "%.2fkm", kilo)
        HStack(spacing: 55.0) {
            VStack(alignment: .leading) {
                Text("Count")
                    .font(.title3)
                    .padding(.bottom, -20)
                Text(activity.amount)
                    .font(.largeTitle)
            }
            VStack(alignment: .leading) {
                Text("Distance")
                    .font(.title3)
                    .padding(.bottom, -20)
                Text(formattedString)
                    .font(.largeTitle)
            }
        }//.padding(.trailing, 85)
            .fontWeight(.semibold)
    }
}

#Preview {
    CardView(activity: Activity(id: 0, title: "Daily Steps", subtitle: "Goal: 10,000", image: "figure.walk", amount: "6,752"))
//    InfoView(activity: Activity(id: 0, title: "Daily Steps", subtitle: "Goal: 10,000", image: "figure.walk", amount: "6,752"))
}
