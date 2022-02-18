//
//  AppSection.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-02-18.
//

import SwiftUI

struct AppSectionInt: View {
    @Binding var value: Int
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
            TextField(placeholder, value: $value, format: .number)
                .padding(5)
                .background(Color.secondary)
                .cornerRadius(5)
        }
        .padding(.horizontal, 10)
        .padding(.bottom, 10)
        .padding(.top, -15)
    }
}


struct  AppSectionInt_Previews: PreviewProvider {
    static var previews: some View {
        AppSectionInt(value: .constant(0), title: "", placeholder: "")
    }
}


