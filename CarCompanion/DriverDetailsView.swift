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
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Driver.entity(), sortDescriptors: []) var driver: FetchedResults<Driver>
    
    var body: some View {
        Group {
            AppTitleView(title: "DRIVER DETAILS")
                .padding(.top, 15)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
            Section("Owner's Full Name") {
                TextField("Who is the car Owner?", text: $owner).id(owner)
            }
            Section("Driver's License") {
                TextField("Enter Your Driver's License Number", text: $driverLicense).id(driverLicense)
            }
        }
        .onAppear(perform: {
            DispatchQueue.main.async {
                self.owner = driver.first?.name ?? ""
                self.driverLicense = driver.first?.licenseNumber ?? ""
            }
           
        })
    }
}


struct DriverDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DriverDetailsView(owner: .constant(""), driverLicense: .constant(""))
    }
}
