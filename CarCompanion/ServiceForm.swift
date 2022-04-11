//
//  ServiceForm.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-04-08.
//

import SwiftUI

struct ServiceForm: View {
    @Environment(\.dismiss) var dismiss
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Driver.entity(), sortDescriptors: []) var driver: FetchedResults<Driver>
    @FetchRequest(entity: Car.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Car.timeStamp, ascending: true)]) var cars: FetchedResults<Car>
    
    @State var shopName: String = ""
    @State var dateOfService: Date = Date()
    @State var serviceName: String = ""
    @State var cost: Double = 0.0
    @State var totalCost: Double = 0.0
    @State var services: [Services] = []
    var body: some View {
        NavigationView {
            VStack {
                AppSection(value: $shopName, title: "SERVICE LOCATION", placeholder: "Enter The Auto Shop Name")
                AppDatePicker(title: "DATE OF SERVICE", dateOfService: $dateOfService)
                AppSectionDouble(value: $totalCost, title: "TOTAL COST", placeholder: "Enter Total Service Cost")
                AppSectionMulti(value: $serviceName, cost:$cost, title: "ADD SERVICE RECORD", placeholder1: "Description", placeholder2: "Cost") {
                    if !serviceName.isEmpty && cost != 0 {
                        let service = Services(context: viewContext)
                        service.desc = serviceName
                        service.cost = cost
                       
                            services.append(service)
                        
                    }
                    
                    
                }
                List {
                    ForEach(services) { service in
                        HStack {
                            Text(service.desc!)
                            Spacer()
                            Text(service.cost, format: .currency(code: Locale.current.currencyCode!))
                        }
                    }
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
                        saveServiceRecord()
                        dismiss()
                    })
                        .disabled(shopName.isEmpty ||  totalCost == 0 || services.isEmpty)
                }
            }
        }
    }
    func saveServiceRecord() {
        if !driver.isEmpty && !cars.isEmpty {
            let value = UserDefaults.standard.string(forKey: "CurrentVehicle")
            let vehicle = driver.first!.Cars.first(where: {$0.plateNumber == value})!
            if let dashboard = vehicle.dashboard {
                let serviceRecord = ServiceRecords(context: viewContext)
                serviceRecord.shopName = shopName
                serviceRecord.dateOfService = dateOfService
                serviceRecord.totalCost = totalCost
                for service in services {
                    serviceRecord.addToServices(service)
                }
                                               
                driver.first!.Cars.first(where: {$0.plateNumber == value})!.dashboard?.addToServiceRecords(serviceRecord)
                
                Driver.saveContext(viewContext: viewContext)
            }
        }
    }
}

struct ServiceForm_Previews: PreviewProvider {
    static var previews: some View {
        ServiceForm()
    }
}
