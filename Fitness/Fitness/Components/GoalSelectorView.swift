//
//  GoalSelectorView.swift
//  Fitness
//
//  Created by Simone Sarnataro on 18/11/23.
//

import SwiftUI

struct GoalSelectorView: View {
    @State var counter: Int = 120
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "minus.circle.fill")
                    .resizable()
                    .foregroundColor(.ringColor1)
                    .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .onTapGesture {
                        if counter != 0{
                            self.counter -= 10
                        }
                        print(counter)
                    }
                    .gesture(
                        LongPressGesture()
                            .onChanged { _ in
                                self.counter += 10
                                print(counter)
                            }
                            .onEnded { _ in
                                print(counter)
                            }
                    )
                
                Text("\(counter)")
                    .font(.system(size: 70))
                    .fontWeight(.bold)
                    .frame(width: 180)
                
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .foregroundColor(.ringColor1)
                    .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .onTapGesture {
                        self.counter += 10
                        print(counter)
                    }
                    .gesture(
                        LongPressGesture()
                            .onChanged { _ in
                                self.counter += 10
                                print(counter)
                            }
                            .onEnded { _ in
                                print(counter)
                            }
                    )
            }
            Text("KILOCALORIES/DAY")
                .font(.title2)
                .fontWeight(.black)
        }
    }
}

#Preview {
    GoalSelectorView()
}
