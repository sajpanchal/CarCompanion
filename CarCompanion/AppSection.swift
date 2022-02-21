//
//  AppSection.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-02-18.
//

import SwiftUI

struct AppSection: View {
    @Environment (\.colorScheme) var colorScheme
    @Binding var value: String
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
            TextField(placeholder, text: $value)
                .padding(.horizontal,2)
                .padding(.vertical, 10)
                .background(colorScheme == .dark ? Color.black : Color( red: 0.9, green: 0.9, blue: 0.9, opacity: 1.0))
                .cornerRadius(5)
        }
        .padding(.horizontal, 0)
        .padding(.bottom, 10)
        .padding(.top, -15)
    }
}


struct AppSection_Previews: PreviewProvider {
    static var previews: some View {
        AppSection(value: .constant(""), title: "", placeholder: "")
    }
}
