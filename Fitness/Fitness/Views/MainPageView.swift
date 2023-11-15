//
//  HomeView.swift
//  Fitness
//
//  Created by Simone Sarnataro on 15/11/23.
//

import SwiftUI

struct MainPageView: View {
    let currentDateTime = Date()
    @State var isShowingAccount: Bool = false
    @State var scrollViewOffset: CGFloat = 0
    
    func formattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM"
        return dateFormatter.string(from: date)
    }
    
    @EnvironmentObject var manager: HealthManager
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(alignment: .leading) {
                    HStack{
                        VStack(alignment: .leading) {
                            Text(formattedDate(date: currentDateTime))
                            Text("Summary")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                        }
                        Spacer()
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .onTapGesture {
                                isShowingAccount.toggle()
                            }
                    }.frame(width: 330)
                    
                    Section {
                        Text("Activity")
                            .font(.title)
                            .fontWeight(.bold)
                        ActivityCardView()
                    }
                    
//                    ForEach(manager.activities.sorted(by: { $0.value.id < $1.value.id}), id: \.key){ item in
//                        LazyVGrid(columns: Array(repeating: GridItem(spacing:20), count: 2)){
//                            
//                            CardView(activity: item.value)
//                        }
//                        InfoView(activity: item.value)
//                    }
//                    ChartView()
                }
            }.scrollIndicators(.hidden)
            
        }
        .sheet(isPresented: $isShowingAccount, content: {
            ModalView().presentationDetents([.large])
        })
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

#Preview {
    MainPageView()
}
