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
        VStack {
            AppTitleView(title: "DRIVER DETAILS")
                .padding(.top, 15)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
            AppSection(value: $owner, title: "Owner's Full Name", placeholder: "Who is the car Owner?")
           AppSection(value: $driverLicense, title: "Driver's License", placeholder: "Enter Your Driver's License Number")
           
        }
        
    }
}


struct DriverDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DriverDetailsView(owner: .constant(""), driverLicense: .constant(""))
    }
}
