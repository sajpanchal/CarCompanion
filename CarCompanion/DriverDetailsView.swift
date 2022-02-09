//
//  DriverDetailsView.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-02-09.
//

import SwiftUI

struct DriverDetailsView: View {
    @Binding var owner: String
    @Binding var driverLicense: String
    
    var body: some View {
        Group {
            TitleView(title: "DRIVER DETAILS")
                .padding(.top, 15)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
            Section("Owner's Full Name") {
                TextField("Who is the car Owner?", text: $owner)
            }
            Section("Driver's License") {
                TextField("Enter Your Driver's Lincense Number", text: $driverLicense)
            }
        }
    }
}


struct DriverDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DriverDetailsView(owner: .constant(""), driverLicense: .constant(""))
    }
}