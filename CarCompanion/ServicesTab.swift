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
                AppButton(text: "Add New Entry", color: .blue, action: {
                    serviceView = true
                }, width: 300, height: 40)
                   .padding(.vertical, 30)
                                  
             AppTitleView(title: "SERVICES/REPAIRS HISTORY")
               VStack {
                   List {
                       ForEach(driver.first!.Cars[driver.first!.Cars.firstIndex(where: {$0.plateNumber == UserDefaults.standard.string(forKey: "CurrentVehicle")})!].dashboard?.serviceRecordsArray ?? [], id: \.self) { serviceRecord in
                           HStack {
                               Text(serviceRecord.shopName!)
                               Spacer()
                               Text(serviceRecord.totalCost, format: .currency(code: Locale.current.currencyCode!))
                           }
                           
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
