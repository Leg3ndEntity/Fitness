//
//  AccountView.swift
//  Fitness
//
//  Created by Simone Sarnataro on 15/11/23.
//

import SwiftUI

struct AccountView: View {
    @State private var birthday: Date = (Calendar.current.date(byAdding: DateComponents(year: -20), to: Date()) ?? Date())
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @State var isShowingPicker: Bool = false
    
    func formattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    @State var click: Bool = false
    var body: some View {
        ScrollView{
            VStack {
                Text("Personalise Fitness and Health")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Text("This information ensures Fitness and \nHealth data are as accurate as possible. \nThese datails are not shared with Apple")
                    .font(.headline)
                    .fontWeight(.regular)
            }.multilineTextAlignment(.center)
                .frame(width: 350)
                .padding(.top, 20)
            List{
                HStack{
                    Text("Date of Birth")
                    Spacer()
                    Text(formattedDate(date: birthday))
                        .foregroundColor(click ? /*@START_MENU_TOKEN@*/Color("AccentColor1")/*@END_MENU_TOKEN@*/ : .gray)
                        .onTapGesture {
                            isShowingPicker.toggle()
                            click.toggle()
                        }
                }
                Picker(selection: .constant(1), label: Text("Sex")) {
                    Text("Not Set").tag(1)
                    Text("Female").tag(2)
                    Text("Male").tag(2)
                    Text("Other").tag(2)
                }
                Picker(selection: .constant(1), label: Text("Height")) {
                    Text("Not Set").tag(1)
                    ForEach(30..<275) {
                        Text("\($0) cm")
                    }
                }
                Picker(selection: .constant(1), label: Text("Weight")) {
                    Text("Not Set").tag(1)
                    ForEach(0..<454) {
                        Text("\($0) kg")
                    }
                }
            }.frame(height: 250)
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width:350, height:60)
                    .foregroundColor(Color(red: 0.169, green: 0.169, blue: 0.182))
                
                Text("Done")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(.label))
            }.padding(.top, 145)
                .onTapGesture {
                    dismiss()
                }
        }.sheet(isPresented: $isShowingPicker, content: {
            DatePicker(selection: $birthday, displayedComponents: .date){}
                .padding(10)
                .labelsHidden()
                .datePickerStyle(.wheel)
                .presentationDetents([.fraction(0.3)])
        })
    }
}

#Preview {
    AccountView()
}
