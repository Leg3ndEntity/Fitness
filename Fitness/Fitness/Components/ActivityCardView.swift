//
//  ActivityCardView.swift
//  Fitness
//
//  Created by Simone Sarnataro on 15/11/23.
//

import SwiftUI

struct ActivityCardView: View {

    @EnvironmentObject var healthKitManager: HealthKitManager
    let redColor = Color(#colorLiteral(red: 0.9803921569, green: 0.06666666667, blue: 0.3137254902, alpha: 1))
    
    var body: some View {
        
        ZStack {
            Color(uiColor: .systemGray6)
            VStack(spacing: 20){
                ZStack(alignment: .center){
                    VStack(alignment: .leading, spacing: 10){
                        VStack(alignment: .leading, spacing: 0){
                            Text("Move")
                                .fontWeight(.bold)
                            HStack {
                                Text("\(healthKitManager.energyBurnedValue)/120")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                Text("KCAL")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Spacer()
                            }.frame(width: 150)
                                .foregroundColor(redColor)
                        }
                        VStack(alignment: .leading, spacing: 0){
                            Text("Steps")
                                .fontWeight(.bold)
                            Text("\(healthKitManager.stepValue)")
                                .font(.title3)
                                .fontWeight(.bold)
                            .foregroundColor(.gray)
                        }
                        VStack(alignment: .leading, spacing: 0){
                            Text("Distance")
                                .fontWeight(.bold)
                            Text("\(healthKitManager.walkDistance)KM")
                                .font(.title3)
                                .fontWeight(.bold)
                            .foregroundColor(.gray)
                        }
                    }.padding(.trailing, 160)
                    Spacer()
                    
                    ZStack {
                        RingView(percentage: 1.3, backgroundColor: .ringColor2, startColor: .ringColor1, endColor: .ringColor3, thickness: 25)
                            .scaleEffect(1.2)
                        .padding(.leading, 180)
                        
                    Image(systemName: "arrow.forward")
                        .resizable()
                        .frame(width: 15, height: 15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.black)
                        .padding(.bottom, 122)
                        .padding(.leading, 178)
                        .bold()
                    }
                    
                }
            }
            .frame(width: 330, height: 190, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .padding()
        }.frame(width: 350, height: 190)
            
        .cornerRadius(15)
    }
}

#Preview {
    ActivityCardView()
        .preferredColorScheme(.dark)
}
