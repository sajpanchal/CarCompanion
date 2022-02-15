//
//  SettingsView.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-02-08.
//

import SwiftUI


struct SettingsView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Driver.entity(), sortDescriptors: []) var driver: FetchedResults<Driver>
    @FetchRequest(entity: Car.entity(), sortDescriptors: []) var cars: FetchedResults<Car>
    
    @State var vehicles: [Car] = []
    @State var vehicle: Int = 0
    
    @State var make: String
    @State var model: String
    @State var year: Int
    @State var odometer: Double
    @State var fuelCapacity: Double
    @State var licensePlate: String
        
    @State var owner: String
    @State var driverLicense: String
    
    @State var addNewVehicle: Bool = false
                
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Form {
                    if !cars.isEmpty && !driver.isEmpty {
                        VehicleSelectionView(vehicles: $vehicles, vehicle: $vehicle)
                    }
                    
                    CarDetailsView(make: $make, model: $model, year: $year, odometer: $odometer, fuelCapacity: $fuelCapacity, licensePlate: $licensePlate)
                    
                    DriverDetailsView(owner: $owner, driverLicense: $driverLicense)
                    
                    VStack {
                        AppButton(text: "Save", color: .blue, action: {
                            if driver.isEmpty {
                                createDriver()
                            }
                            if cars.isEmpty {
                                let newCar = Car(context: viewContext)
                                saveCar(car: newCar)
                            }
                            else {
                                let car = cars.first(where: { $0.plateNumber == vehicles[vehicle].plateNumber })
                                if let car = car {
                                    saveCar(car: car)
                                }
                            }
                        }, width: 300, height: 40)
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                }
            }
            .toolbar(content: {
                if !driver.isEmpty {
                    Button("ADD NEW VEHICLE") {
                       addNewVehicle = true
                    }
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(20)
                    .padding(5)
                }
            })
            .sheet(isPresented: $addNewVehicle, content: {
                NewVehicleView()
            })
            .navigationTitle(driver.isEmpty ? "Setup Account" : "Settings")
        }
    }
    
    func createDriver() {
        let newDriver = Driver(context: viewContext)
        newDriver.licenseNumber = driverLicense
        newDriver.name = owner
        do {
            try viewContext.save()
        }
        catch {
            print("Couldn't save driver details...")
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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(make: "", model: "", year: 2020, odometer: 0.0, fuelCapacity: 0, licensePlate: "", owner: "", driverLicense: "")
    }
}


