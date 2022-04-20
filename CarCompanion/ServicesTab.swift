//
//  ServicesTab.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-03-17.
//

import SwiftUI

struct ServicesTab: View {
    @State var serviceView: Bool = false
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Driver.entity(), sortDescriptors: []) var driver: FetchedResults<Driver>
    @FetchRequest(entity: Car.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Car.timeStamp, ascending: true)]) var cars: FetchedResults<Car>
    var body: some View {
        NavigationView {
           VStack {
               NavigationLink(destination: ServiceForm( shopName: "", dateOfService: Date() , serviceName: "", cost: 0.0, totalCost: 0.0, services: []), label: {
                  Text("Add New Entry")
                       .frame(width: 300, height: 40, alignment: .center)
                      
               })
                 //  .frame(width: 300, height: 40, alignment: .center)
                   .background(Color.blue)
                   .cornerRadius(100)
            /*    AppButton(text: "Add New Entry", color: .blue, action: {
                    serviceView = true
                }, width: 300, height: 40)
                   .padding(.top, 30)
                   .padding(.horizontal, 15)*/
               AppTitleView(title: "SERVICES/REPAIRS HISTORY", font: .title3, weight: .semibold, color: .gray)
               VStack {
                   List {
                       ForEach(driver.first!.Cars[driver.first!.Cars.firstIndex(where: {$0.plateNumber == UserDefaults.standard.string(forKey: "CurrentVehicle")})!].dashboard?.serviceRecordsArray ?? [], id: \.self) { serviceRecord in
                           NavigationLink(destination: ServiceForm( shopName: serviceRecord.shopName!, dateOfService: serviceRecord.dateOfService!, serviceName: "", cost: 0.0, totalCost: serviceRecord.totalCost, services: serviceRecord.servicesArray), label: {
                               ServiceRecordsList(serviceRecord: serviceRecord)
                           } )
                          
                       }
                   }
               }
               .frame(width: 400, height: 400, alignment: .center)
               .background(Color.red)
            }
           
           .sheet(isPresented: $serviceView) {
               ServiceForm()
           }
           .navigationTitle("Services/Repairs")
               
        }
    }
}

struct ServicesTab_Previews: PreviewProvider {
    static var previews: some View {
        ServicesTab()
    }
}

