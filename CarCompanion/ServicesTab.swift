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
                   .padding(.top, 30)
                   .padding(.horizontal, 15)
               AppTitleView(title: "SERVICES/REPAIRS HISTORY", font: .title3, weight: .semibold, color: .gray)
               VStack {
                   List {
                       ForEach(driver.first!.Cars[driver.first!.Cars.firstIndex(where: {$0.plateNumber == UserDefaults.standard.string(forKey: "CurrentVehicle")})!].dashboard?.serviceRecordsArray ?? [], id: \.self) { serviceRecord in
                           VStack {
                               HStack {
                                   VStack {
                                       Text("Location")
                                           .font(.system(size: 14, weight: .semibold, design: .default))
                                           .foregroundColor(.gray)
                                       Text(serviceRecord.shopName!)
                                           .font(.subheadline)
                                           .fontWeight(.bold)
                                           .foregroundColor(.blue)
                                   }                                 
                                   Spacer()
                                   VStack {
                                       Text("Total Cost")
                                           .font(.system(size: 14, weight: .semibold, design: .default))
                                           .foregroundColor(.gray)
                                       Text(serviceRecord.totalCost, format: .currency(code: Locale.current.currencyCode!))
                                           .font(.subheadline)
                                           .fontWeight(.bold)
                                           .foregroundColor(.red)
                                   }
                               }
                               Spacer()
                               Text(serviceRecord.DateOfService)
                                   .font(.caption2)
                                   .fontWeight(.light)
                                   .foregroundColor(.gray)
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
