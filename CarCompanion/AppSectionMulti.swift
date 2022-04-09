//
//  AppSectionMulti.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-04-09.
//

import SwiftUI

struct AppSectionMulti: View {
    @Environment (\.colorScheme) var colorScheme
    @Binding var value: String
    @Binding var cost: Double
    var title: String
    var placeholder1: String
    var placeholder2: String
    var action: () -> ()
    var body: some View {
        HStack {
        Text(title)
           .font(.footnote)
           .foregroundColor(Color.gray)
           .frame(height: 40, alignment: .leading)
           .padding(.leading, 0)
            Spacer()
        }
        HStack {
            TextField(placeholder1, text: $value)
                .padding(.horizontal,2)
                .padding(.vertical, 10)
                .background(colorScheme == .dark ? Color.black : Color( red: 0.9, green: 0.9, blue: 0.9, opacity: 1.0))
                .cornerRadius(5)
            TextField(placeholder2, value: $cost, format: .number)
                .frame(width: 90)
                .padding(.horizontal,2)
                .padding(.vertical, 10)
                .background(colorScheme == .dark ? Color.black : Color( red: 0.9, green: 0.9, blue: 0.9, opacity: 1.0))
                .cornerRadius(5)
                
            Button("Add", action: {
                action()
            })
        }
        .padding(.horizontal, 0)
        .padding(.bottom, 10)
        .padding(.top, -15)
    }
}

struct AppSectionMulti_Previews: PreviewProvider {
    static var previews: some View {
        AppSectionMulti(value: .constant(""), cost: .constant(0.0), title: "", placeholder1: "", placeholder2: "", action: {})
    }
}
