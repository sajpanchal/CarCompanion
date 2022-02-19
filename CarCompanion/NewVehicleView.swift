//
//  NewVehicleView.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-02-15.
//

import SwiftUI

struct NewVehicleView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Car.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Car.timeStamp, ascending: true)]) var cars: FetchedResults<Car>
    @FetchRequest(entity: Driver.entity(), sortDescriptors: []) var driver: FetchedResults<Driver>
    
    @State var make: String = ""
    @State var model: String = ""
    @State var year: Int = 0
    @State var odometer: Double = 0.0
    @State var fuelCapacity: Double = 0.0
    @State var licensePlate: String = ""
    
    @Binding var vehicles: [Car]
    var latestYear = { () -> Int in
        let date = Date()
        let calender = Calendar.current
        let component = calender.dateComponents([.year], from: date)
        return component.year!
        
    }()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Form {
                    AppTitleView(title: "CAR DETAILS")
                        .padding(.top, 20)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets())
                  
                  
                      
                            Section("Make") {
                                TextField("What brand is this car?", text: $make)

                            }
                            Section("Model") {
                                TextField("What model is this car?", text: $model)//.focused($focus)//.id(model)
                            }
                                                                        
                   
                    Section("Year") {
                        Picker("What year is your car make?", selection: $year) {
                            ForEach((1900...latestYear).reversed(), id: \.self) {
                                Text(String($0))
                            }
                        }
                    }
                    Section("License plate") {
                        TextField("What is the Car License Plate Number", text: $licensePlate)//.id(licensePlate)
                            
                    }
                    Section("ODOMETER (in KM)") {
                        TextField("What is your car odometer reading status?", value: $odometer, format: .number)//.id(odometer)
                    }
                    Section("Fuel Capacity (in Litre)") {
                        TextField("What is the car fuel capacity?", value:$fuelCapacity, format: .number)//.id(fuelCapacity)
                    }
                    
                    VStack {
                        AppButton(text: "Save", color: .blue, action: {
                            saveCar(car: Car(context: viewContext))
                        }, width: 300, height: 40)
                        
                    }
                    .padding(.vertical, 20)
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
        car.timeStamp = Date()
        car.driver = driver.first!
        do {
            try viewContext.save()
            vehicles = []
            for car in cars {
                vehicles.append(car)
            }
            dismiss()
        }
        catch {
            print("Couldn't save car details...")
        }
     
    }
}

struct NewVehicleView_Previews: PreviewProvider {
    static var previews: some View {
        NewVehicleView(vehicles: .constant([]))
    }
}
