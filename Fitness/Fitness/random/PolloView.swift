////
////  HomeView.swift
////  Fitness
////
////  Created by Simone Sarnataro on 14/11/23.
////
//
//import SwiftUI
//
//struct PolloView: View {
//    @EnvironmentObject var manager: HealthManager
//    var body: some View {
//        VStack{
//            ForEach(manager.activities.sorted(by: { $0.value.id < $1.value.id}), id: \.key){ item in
//                LazyVGrid(columns: Array(repeating: GridItem(spacing:20), count: 2)){
//                    
//                    CardView(activity: item.value)
//                }
//                InfoView(activity: item.value)
//            }
//            ChartView()
//            
//        }.padding(.horizontal)
//    }
//}
//
//#Preview {
//    PolloView()
//        .environmentObject(HealthManager())
//}
