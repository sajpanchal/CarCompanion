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
    @State var vehicle: Car = Car.fetchData() ?? Car()
    
    @State var make: String = ""
    @State var model: String = ""
    @State var year: Int = 0
    @State var odometer: Double = 0.0
    @State var fuelCapacity: Double = 0.0
    @State var licensePlate: String = ""
        
    @State var owner: String = ""
    @State var driverLicense: String = ""
    
    @State var addNewVehicle: Bool = false
    var latestYear = { () -> Int in
        let date = Date()
        let calender = Calendar.current
        let component = calender.dateComponents([.year], from: date)
        return component.year!
        
    }()
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
            .onAppear(perform: {
                if !driver.isEmpty && !cars.isEmpty {
                   vehicles = []
                   
                    for car in cars {
                       print(car)
                       vehicles.append(car)
                   }
                    
                    getCarData()
                    
                    getDriverData()
                }
           })
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
    
    func getCarData() {
             
        let car = vehicle
        print("-----------------Get Car data--------------------")
        DispatchQueue.main.async {
            self.make = car.make ?? "n/a"
            self.model = car.model ?? "n/a"
            self.fuelCapacity = car.fuelCapacity
            self.licensePlate = car.plateNumber ?? ""
            self.year = Int(car.year)
            self.odometer = car.odometer
        }
        
       
        print(make)
        print(model)
        print(fuelCapacity)
        print(licensePlate)
        print(year)
        print(odometer)
       
    }
    func getDriverData() {
                    
        let car = vehicle
        print("-----------------Get Vehicle data--------------------")
        DispatchQueue.main.async {
            self.owner = car.driver?.name ?? ""
            self.driverLicense = car.driver?.licenseNumber ?? ""
        }

             
        print(owner)
        print(driverLicense)
    }
}



struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(/*make: "", model: "", year: 2020, odometer: 0.0, fuelCapacity: 0, licensePlate: "", owner: "", driverLicense: ""*/)
    }
}


