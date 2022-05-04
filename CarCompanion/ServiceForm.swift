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
    var serviceRecord: ServiceRecords?
    @State var shopName: String = ""
    @State var dateOfService: Date = Date()
    @State var serviceName: String = ""
    @State var cost: Double = 0.0
    @State var totalCost: Double = 0.0
    @State var services: [Services] = []
    var uniqueid: UUID
    var body: some View {

     
            ScrollView(.vertical) {
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
                            serviceName = ""
                            cost = 0.0
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
                        .onDelete(perform: deleteService)
                    }
                    
                    .frame(height: 250, alignment: .center)
                }
                .navigationBarTitle("Service Record")
                .frame(alignment: .top)
                .padding()
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button("Discard", action: {
                            resetForm()
                           
                        })
                            .disabled(shopName.isEmpty && totalCost == 0 && services.isEmpty)
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
    func deleteService(at offsets: IndexSet) {
        for offset in offsets {
            services.remove(at: offset)
        }
    }
    func saveServiceRecord() {
        if !driver.isEmpty && !cars.isEmpty {
            let value = UserDefaults.standard.string(forKey: "CurrentVehicle")
            let vehicle = driver.first!.Cars.first(where: {$0.plateNumber == value})!
            if let dashboard = vehicle.dashboard {
              
          
                if let serviceRecord = dashboard.serviceRecordsArray.first(where: { record in record.uniqueID == uniqueid}) {
                    print("existing service record found.")
                    serviceRecord.shopName = shopName
                    serviceRecord.dateOfService = dateOfService
                    serviceRecord.totalCost = totalCost
                    serviceRecord.services = nil
                    for service in services {
                        serviceRecord.addToServices(service)
                    }
                    Driver.saveContext(viewContext: viewContext)
                }
                else {
                    print("new service record found.")
                    let serviceRecord = ServiceRecords(context: viewContext)
                    serviceRecord.shopName = shopName
                    serviceRecord.dateOfService = dateOfService
                    serviceRecord.totalCost = totalCost
                    serviceRecord.uniqueID = UUID()
                    for service in services {
                        serviceRecord.addToServices(service)
                    }
                    driver.first!.Cars.first(where: {$0.plateNumber == value})!.dashboard?.addToServiceRecords(serviceRecord)
                }
                
                Driver.saveContext(viewContext: viewContext)
            }
        }
    }
    
    func resetForm() {
        shopName = ""
        dateOfService = Date()
        serviceName = ""
        cost = 0.0
        totalCost = 0.0
        services = []
    }
}

struct ServiceForm_Previews: PreviewProvider {
    static var previews: some View {
        ServiceForm(uniqueid: UUID())
    }
}
