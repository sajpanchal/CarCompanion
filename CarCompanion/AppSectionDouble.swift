//
//  SwiftUIView.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-02-18.
//

import SwiftUI

struct AppSectionDouble: View {
    @Environment (\.colorScheme) var colorScheme
    @Binding var value: Double
    var title: String
    var placeholder: String
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
            TextField(placeholder, value: $value, format: .number)
                .padding(.horizontal, 2)
                .padding(.vertical, 10)
                .background(colorScheme == .dark ? Color.black : Color( red: 0.9, green: 0.9, blue: 0.9, opacity: 1.0))
                .cornerRadius(5)
        }
        .padding(.horizontal, 0)
        .padding(.bottom, 10)
        .padding(.top, -15)
    }
}


struct  AppSectionDouble_Previews: PreviewProvider {
    static var previews: some View {
        AppSectionDouble(value: .constant(0), title: "", placeholder: "")
    }
}
