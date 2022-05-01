//
//  ServicesTab.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-03-17.
//

import SwiftUI

struct ServicesTab: View {
    @State var serviceView: Bool = false
    @State var listID: UUID = UUID()
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Driver.entity(), sortDescriptors: []) var driver: FetchedResults<Driver>
    @FetchRequest(entity: Car.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Car.timeStamp, ascending: true)]) var cars: FetchedResults<Car>
    var body: some View {
        NavigationView {
           VStack {
               NavigationLink(destination: ServiceForm(shopName: "", dateOfService: Date() , serviceName: "", cost: 0.0, totalCost: 0.0, services: [], uniqueid: UUID()).onDisappear(perform: {
                   listID = UUID()
               }), label: {
                  Text("Add New Entry")
                       .frame(width: 300, height: 40, alignment: .center)
                      
               })                
                   .background(Color.blue)
                   .cornerRadius(100)
            
               AppTitleView(title: "SERVICES/REPAIRS HISTORY", font: .title3, weight: .semibold, color: .gray)
               VStack {
                   List {
                       ForEach(driver.first!.Cars[driver.first!.Cars.firstIndex(where: {$0.plateNumber == UserDefaults.standard.string(forKey: "CurrentVehicle")})!].dashboard?.serviceRecordsArray ?? [], id: \.self) { serviceRecord in
                           NavigationLink(destination: ServiceForm( shopName: serviceRecord.shopName!, dateOfService: serviceRecord.dateOfService!, serviceName: "", cost: 0.0, totalCost: serviceRecord.totalCost, services: serviceRecord.servicesArray, uniqueid: serviceRecord.uniqueID!).onDisappear(perform: {
                               listID = UUID()
                           }), label: {
                               ServiceRecordsList(serviceRecord: serviceRecord)
                           } )
                          
                       }
                       .onDelete(perform: deleteServiceRecord)
                       
                   }
                   .id(listID)
               }
               .frame(width: 400, height: 400, alignment: .center)
               .background(Color.red)
            }
           
           .sheet(isPresented: $serviceView) {
               ServiceForm(uniqueid: UUID())
           }
           .navigationTitle("Services/Repairs")
               
        }
    }
   func deleteServiceRecord(at offsets: IndexSet) {
        for offset in offsets {
            if let service =  driver.first!.Cars[driver.first!.Cars.firstIndex(where: {$0.plateNumber == UserDefaults.standard.string(forKey: "CurrentVehicle")})!].dashboard?.serviceRecordsArray[offset] {
                driver.first!.Cars[driver.first!.Cars.firstIndex(where: {$0.plateNumber == UserDefaults.standard.string(forKey: "CurrentVehicle")})!].dashboard?.removeFromServiceRecords(service)
                Driver.saveContext(viewContext: viewContext)
            }
        }
    }
 }

struct ServicesTab_Previews: PreviewProvider {
    static var previews: some View {
        ServicesTab()
    }
}

