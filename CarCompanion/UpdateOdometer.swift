//
//  UpdateOdometer.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-01-20.
//

import SwiftUI
import CoreData

struct UpdateOdometer: View {
    @State var value = 0.0
    @Environment(\.dismiss) var dismiss
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: CarDashboard.entity(), sortDescriptors: []) var carDashboard: FetchedResults<CarDashboard>
    var body: some View {
        VStack {
            TextField("odometer readings", value:$value, format: .number)
            Button("Save") {
                if !carDashboard.isEmpty {
                    carDashboard.first?.odometer = value
                    CarDashboard.saveContext(viewContext: viewContext)
                }
                else {
                    let newEntry = CarDashboard(context: viewContext)
                    newEntry.odometer = value
                    newEntry.currentTravel =  0.0
                    newEntry.currentFuel = 0.0
                    CarDashboard.saveContext(viewContext: viewContext)
                }
               dismiss()
            }
           
        }
      
        
        
    }
}

struct UpdateOdometer_Previews: PreviewProvider {
    static var previews: some View {
        UpdateOdometer()
    }
}
