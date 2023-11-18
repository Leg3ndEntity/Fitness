//
//  GoalView.swift
//  Fitness
//
//  Created by Simone Sarnataro on 15/11/23.
//

import SwiftUI

struct GoalView: View {
    
    @State var num = 1
    
    var body: some View {
        VStack {
            VStack{
                Text("Your Daily Move Goal")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Text("Set a goal based on how active you are, or \nhow active you'd like to be, each day.")
                    .font(.headline)
                    .fontWeight(.regular)
            }.multilineTextAlignment(.center)
            
            Picker(selection: $num, label: Text("Modality")) {
                Text("Lightly").tag(1)
                Text("Moderate").tag(2)
                Text("Highly").tag(3)
            }.pickerStyle(.segmented)
                .frame(width: 310)
                .padding(.vertical, 30)
            
            GoalSelectorView()
            
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width:350, height:60)
                    .foregroundColor(Color(red: 0.169, green: 0.169, blue: 0.182))
                
                Text("Set Move Goal")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(.label))
            } .padding(.top, 200)
            
            
            
        }
    }
}

#Preview {
    GoalView()
}
