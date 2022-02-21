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
           
            AppSection(value: $owner, title: "OWNER'S FULLNAME", placeholder: "Who is the Owner?")
           AppSection(value: $driverLicense, title: "DRIVER'S LICENSE", placeholder: "Enter Driver's License Number")
           
        }
        .cornerRadius(5)
        
    }
}


struct DriverDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DriverDetailsView(owner: .constant(""), driverLicense: .constant(""))
    }
}
