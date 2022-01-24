//
//  AddFuelView.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-01-21.
//

import SwiftUI
import CoreData

struct AddFuelView: View {
       
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: CarDashboard.entity(), sortDescriptors: []) var carDashboard: FetchedResults<CarDashboard>

    @State var fuelAmount: Double?
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                Text("ADD FUEL AMOUNT")
                   .font(.body)
                   .fontWeight(.semibold)
                   .foregroundColor(Color.gray)
                   .frame(height: 40, alignment: .leading)
                   .padding(.leading, 10)
                    Spacer()
                }
                HStack {
                    TextField("How much fuel have you filled?", value: $fuelAmount, format: .number)
                        .padding()
                        .background(Color.secondary)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
                .padding(.top, -15)
           
                AppButton(text: "Add Fuel", color: Color.blue, action: {
                    if carDashboard.isEmpty {
                        let newEntry = CarDashboard(context: viewContext)
                        newEntry.currentFuel = fuelAmount!
                        newEntry.currentTravel = 0.0
                        newEntry.odometer = 0.0
                    }
                    else {
                        carDashboard.first?.currentFuel = fuelAmount!
                        carDashboard.first?.currentTravel = 0.0
                    }
                    
                    CarDashboard.saveContext(viewContext: viewContext)
                    dismiss()
                    
                }).disabled(fuelAmount == nil)
                Spacer()
            }
            .navigationTitle("At the Fuel Station")
        }
        
       
        
    }
}

struct AddFuelView_Previews: PreviewProvider {
    static var previews: some View {
        AddFuelView()
    }
}