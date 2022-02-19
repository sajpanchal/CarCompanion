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
        VStack {
            HStack {
                Text(title)
                   .font(.footnote)                   
                   .foregroundColor(Color.gray)
                   .frame(alignment: .leading)
                   .padding(.leading, 0)
                Spacer()
            }
            .frame(height: 5)
            .padding(.top, 20)
            Picker(placeholder, selection: $value) {
                ForEach((1900...latestYear).reversed(), id: \.self) {
                    Text(String($0))
                        .padding(5)
                }
            }
            .padding(.vertical,5)
        }
        .padding(.top, -10)
    }
}

struct AppPicker_Previews: PreviewProvider {
    static var previews: some View {
        AppPicker(value: .constant(0), title: "", placeholder: "")
    }
}
