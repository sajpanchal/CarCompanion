//
//  AppDatePicker.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-04-08.
//

import SwiftUI

struct AppDatePicker: View {
    var title: String
    @Binding var dateOfService: Date
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
            DatePicker("When did you do this service?", selection: $dateOfService, displayedComponents: .date)
                .foregroundColor(.gray)            
            .padding(.vertical,5)
        }
        .padding(.top, -10)
    }
}

struct AppDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        AppDatePicker(title: "", dateOfService: .constant(Date()))
    }
}
