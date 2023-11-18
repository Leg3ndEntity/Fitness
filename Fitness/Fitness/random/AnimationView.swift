//
//  AnimationView.swift
//  Fitness
//
//  Created by Simone Sarnataro on 15/11/23.
//

import SwiftUI
import HealthKit

struct AnimationView: View {
    @State private var drawingStroke = false
    
    let greenColor = Color(#colorLiteral(red: 0.7942436934, green: 0.9980496764, blue: 0.09652977437, alpha: 1))
    let blueColor = Color(#colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1))
    let redColor = Color(#colorLiteral(red: 0.9803921569, green: 0.06666666667, blue: 0.3137254902, alpha: 1))
    
    let animation = Animation
        .easeOut(duration: 3)
        .delay(0.5)
 
    var body: some View {
        ZStack {
            ring(for: redColor)
                .frame(width: 198)
            ring(for: greenColor)
                .frame(width: 145)
            ring(for: blueColor)
                .frame(width: 92)
            Image(systemName: "arrow.forward")
                .foregroundColor(.black)
                .padding(.bottom, 197)
                .bold()
            ZStack {
                Image(systemName: "arrow.forward")
                    .foregroundColor(.black)
                    .padding(.bottom, 143)
                Image(systemName: "arrow.forward")
                    .foregroundColor(.black)
                    .padding(.bottom, 143)
                    .padding(.leading, 9)
            }.bold()
                .padding(.trailing, 3)
            Image(systemName: "arrow.up")
                .foregroundColor(.black)
                .padding(.bottom, 91)
                .bold()
        }
        .animation(animation, value: drawingStroke)
        .onAppear { drawingStroke = true }
    }
 
    func ring(for color: Color) -> some View {
        Circle()
            .stroke(style: StrokeStyle(lineWidth: 25))
            .foregroundStyle(Color.gray)
            .overlay {
                Circle()
                    .trim(from: 0, to: drawingStroke ? 1 : 0)
                    .stroke(color.gradient,
                            style: StrokeStyle(lineWidth: 25, lineCap: .round))
            }
            .rotationEffect(.degrees(-90))
    }
}

#Preview {
    AnimationView()
}
