//
//  GoalView.swift
//  Fitness
//
//  Created by Simone Sarnataro on 15/11/23.
//

import SwiftUI

struct GoalView: View {
    @EnvironmentObject var healthKitManager: HealthKitManager
    @Environment(\.dismiss) var dismiss
    @State var num = 1
    @State private var selectedMode = 1
    @State private var counter = 120
    
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
            
            Picker(selection: $selectedMode, label: Text("Mode")) {
                            Text("Lightly").tag(1)
                            Text("Moderately").tag(2)
                            Text("Highly").tag(3)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 310)
                        .padding(.vertical, 30)
                        .onChange(of: selectedMode, perform: { newMode in
                            // Esegui un'azione quando cambia la modalità selezionata
                            switch newMode {
                            case 1:
                                counter = 120
                                print("Lightly selected")
                            case 2:
                                counter = 150
                                print("Moderately selected")
                            case 3:
                                counter = 180
                                print("Highly selected")
                            default:
                                break
                            }
                        })
            
            GoalSelectorView(counter: $counter)
            
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
