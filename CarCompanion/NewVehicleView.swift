//
//  NewVehicleView.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-02-15.
//

import SwiftUI

struct NewVehicleView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Car.entity(), sortDescriptors: []) var cars: FetchedResults<Car>
    @FetchRequest(entity: Driver.entity(), sortDescriptors: []) var driver: FetchedResults<Driver>
    @State var make: String = ""
    @State var model: String = ""
    @State var year: Int = 0
    @State var odometer: Double = 0.0
    @State var fuelCapacity: Double = 0.0
    @State var licensePlate: String = ""
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Form {
                    CarDetailsView(make: $make, model: $model, year: $year, odometer: $odometer, fuelCapacity: $fuelCapacity, licensePlate: $licensePlate)
                    VStack {
                        AppButton(text: "Save", color: .blue, action: {
                            saveCar(car: Car(context: viewContext))
                        }, width: 300, height: 35)
                        
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                }
            }
            .navigationTitle("New Vehicle")
        }
        
    }
    
    func saveCar(car: Car) {
        car.make = make
        car.model = model
        car.fuelCapacity = fuelCapacity
        car.plateNumber = licensePlate
        car.year = Int16(year)
        car.driver = driver.first!
        do {
            try viewContext.save()
        }
        catch {
            print("Couldn't save car details...")
        }
    }
}

struct NewVehicleView_Previews: PreviewProvider {
    static var previews: some View {
        NewVehicleView()
    }
}
