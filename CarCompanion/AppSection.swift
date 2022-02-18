//
//  AppSection.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-02-18.
//

import SwiftUI

struct AppSection: View {
    @Binding var value: String
    var title: String
    var placeholder: String
    var body: some View {
        HStack {
        Text(title)
           .font(.body)
           .fontWeight(.semibold)
           .foregroundColor(Color.gray)
           .frame(height: 40, alignment: .leading)
           .padding(.leading, 10)
            Spacer()
        }
        HStack {
            TextField(placeholder, text: $value)
                .padding(5)
                .background(Color.secondary)
                .cornerRadius(5)
        }
        .padding(.horizontal, 10)
        .padding(.bottom, 10)
        .padding(.top, -15)
    }
}


struct AppSection_Previews: PreviewProvider {
    static var previews: some View {
        AppSection(value: .constant(""), title: "", placeholder: "")
    }
}
