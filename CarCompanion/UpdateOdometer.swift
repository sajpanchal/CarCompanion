//
//  UpdateOdometer.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-01-20.
//

import SwiftUI
import CoreData

struct UpdateOdometer: View {
    @State var value: Double?
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: CarDashboard.entity(), sortDescriptors: []) var carDashboard: FetchedResults<CarDashboard>
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("UPDATE APP ODOMETER")
                       .font(.body)
                       .fontWeight(.semibold)
                       .foregroundColor(Color.gray)
                       .frame(height: 40, alignment: .leading)
                       .padding(.leading, 10)
                    Spacer()
                }
               
                HStack {
                    TextField("What is your car odometer reading?", value:$value, format: .number)
                        .padding()
                        .background(Color.secondary)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
                .padding(.top, -15)
                AppButton(text: "Set App Odometer", color: Color.blue, action: {
                    if !carDashboard.isEmpty {
                        carDashboard.first?.odometer = value!
                    }
                    else {
                        let newEntry = CarDashboard(context: viewContext)
                        newEntry.odometer = value!
                        newEntry.currentTravel =  0.0
                        newEntry.currentFuel = 0.0
                    }
                    CarDashboard.saveContext(viewContext: viewContext)
                    dismiss()
                }, width: 300, height: 40)
               Spacer()
            }
            
            .navigationTitle("Set Odometer")
        }
    }
}

struct UpdateOdometer_Previews: PreviewProvider {
    static var previews: some View {
        UpdateOdometer()
    }
}
