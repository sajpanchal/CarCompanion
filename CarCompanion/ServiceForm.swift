//
//  ServiceForm.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-04-08.
//

import SwiftUI

struct ServiceForm: View {
    @Environment(\.dismiss) var dismiss
    @State var shopName: String = ""
    @State var dateOfService: Date = Date()
    @State var serviceName: String = ""
    @State var cost: Double = 0.0
    @State var totalCost: Double = 0.0
    var body: some View {
        NavigationView {
            VStack {
                AppSection(value: $shopName, title: "SERVICE LOCATION", placeholder: "Enter The Auto Shop Name")
                AppDatePicker(title: "DATE OF SERVICE", dateOfService: $dateOfService)
                AppSectionDouble(value: $totalCost, title: "TOTAL COST", placeholder: "Enter Total Service Cost")
                AppSectionMulti(value: $serviceName, cost:$cost, title: "ADD SERVICE RECORD", placeholder1: "Description", placeholder2: "Cost") {
                    
                }
                List {
                                       
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button("Discard", action: {
                        dismiss()
                    })
                }
                ToolbarItem(placement: .bottomBar) {
                    Button("Save", action: {
                        dismiss()
                    })
                }
            }
        }
    }
}

struct ServiceForm_Previews: PreviewProvider {
    static var previews: some View {
        ServiceForm()
    }
}
