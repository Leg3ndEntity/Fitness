//
//  ActivityCardView.swift
//  Fitness
//
//  Created by Simone Sarnataro on 15/11/23.
//

import SwiftUI


struct ActivityCardView: View {
    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
            VStack(spacing: 20){
                HStack(alignment: .center){
                    VStack(alignment: .leading, spacing: 10){
                        VStack(alignment: .leading, spacing: 0){
                            Text("Move")
                            Text("155/120 KCAL")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        VStack(alignment: .leading, spacing: 0){
                            Text("Steps")
                            Text("4.916")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        VStack(alignment: .leading, spacing: 0){
                            Text("Distance")
                            Text("3,44KM")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                    
                    AnimationView()
                        .scaleEffect(0.55)
                }
            }
            .padding()
        }.frame(width: 330)
        .cornerRadius(15)
        .frame(width: 330, height: 230, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ActivityCardView()
}
