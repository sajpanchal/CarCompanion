//
//  AppPicker.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-02-18.
//

import SwiftUI

struct AppPicker: View {
    @Binding var value: Int
    var title: String
    var placeholder: String
    var latestYear = { () -> Int in
        let date = Date()
        let calender = Calendar.current
        let component = calender.dateComponents([.year], from: date)
        return component.year!
        
    }()
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
            Picker(placeholder, selection: $value) {
                ForEach((1900...latestYear).reversed(), id: \.self) {
                    Text(String($0))
                        .padding(5)
                       
                }
            }
               
        }
        .padding(.horizontal, 10)
        .padding(.bottom, 10)
        .padding(.top, -15)
    }
}

struct AppPicker_Previews: PreviewProvider {
    static var previews: some View {
        AppPicker(value: .constant(0), title: "", placeholder: "")
    }
}
