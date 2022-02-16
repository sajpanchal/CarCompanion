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
    @FetchRequest(entity: Car.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Car.timeStamp, ascending: true)]) var cars: FetchedResults<Car>
    
    @State var vehicles: [Car] = []
    @State var vehicle: Car = Car.fetchData()!
    
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
                                let car = cars.first(where: { $0.plateNumber == vehicle.plateNumber })
                                if let car = car {
                                    saveCar(car: car)
                                }
                            }
                            vehicles = []
                            
                            for car in cars {
                                vehicles.append(car)
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
                NewVehicleView(vehicles: $vehicles)
            })
            .onAppear(perform: {
                DispatchQueue.main.async {
                if !driver.isEmpty && !cars.isEmpty {
                    vehicles = []
                    
                    for car in cars {
                        print(car)
                        vehicles.append(car)
                    }
                    
                        getData()
                    }
                }
                
                
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
        car.odometer = odometer
        car.timeStamp = Date()
        car.driver = driver.first!
        do {
            try viewContext.save()
        }
        catch {
            print("Couldn't save car details...")
        }
    }
    func getData() {
       // let driver = driver.first!
        
        
        let car = vehicle
        print("-----------------Get data--------------------")
        print(car)
   
            make = car.make ?? "n/a"
            model = car.model ?? "n/a"
            fuelCapacity = car.fuelCapacity
            licensePlate = car.plateNumber!
            year = Int(car.year)
            odometer = car.odometer
            owner = car.driver!.name ?? "N/A"
            driverLicense = car.driver!.licenseNumber ?? "N/A"
        
           
        
       
        
        
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(make: "x", model: "", year: 2020, odometer: 0.0, fuelCapacity: 0, licensePlate: "", owner: "", driverLicense: "")
    }
}


