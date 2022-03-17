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
    @State var make: String
    @State var model: String
    @State var year: Int
    @State var odometer: Double
    @State var fuelCapacity: Double
    @State var licensePlate: String
    @State var isTapped = false
    @State var owner: String
    @State var driverLicense: String
    @State var addNewVehicle: Bool = false
 //   @ObservedObject var locationFetcher = LocationFetcher()
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
                    AppTitleView(title: "CAR DETAILS")
                        .padding(.top, 20)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets())
                    
                    CarDetailsView(make: $make, model: $model, year: $year, odometer: $odometer, fuelCapacity: $fuelCapacity, licensePlate: $licensePlate)
                    
                    AppTitleView(title: "DRIVER DETAILS")
                        .padding(.top, 15)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets())
                                        
                    DriverDetailsView(owner: $owner, driverLicense: $driverLicense)
                    
                    VStack {
                        AppButton(text: "Save", color: .blue, action: {
                            print("save button tapped.....")
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
                    .padding(.vertical, 20)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                }
            }
            .onAppear(perform: {
                print("on appear called..")
                if !driver.isEmpty && !cars.isEmpty {
                   vehicles = []
                   
                    for car in cars {
                       print(car)
                       vehicles.append(car)
                   }
                }
           })
            .onChange(of: year, perform: { x in
                print("on change called")
                year = x
                print("value is \(year)")
            })
            .onChange(of: vehicle, perform: { vehicle in
                getCarData()
                getDriverData()
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
        .onAppear(perform: {
          
            if !driver.isEmpty && !cars.isEmpty {
                let value = UserDefaults.standard.string(forKey: "CurrentVehicle")
                vehicle = driver.first!.Cars.first(where: {$0.plateNumber == value})!
            }
        })
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
    
        UserDefaults.standard.set(licensePlate, forKey: "CurrentVehicle")
        car.make = make
        car.model = model
        car.fuelCapacity = fuelCapacity
        car.plateNumber = licensePlate
        car.year = Int16(year)
        car.odometer = odometer
        car.timeStamp = Date()
        let driver = driver.first!
        driver.name = owner
        driver.licenseNumber = driverLicense
        car.driver = driver
        
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
        
        self.make = car.make ?? "n/a"
        self.model = car.model ?? "n/a"
        self.fuelCapacity = car.fuelCapacity
        self.licensePlate = car.plateNumber ?? ""
        self.year = Int(car.year)
        self.odometer = car.odometer
                       
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
        self.owner = car.driver?.name ?? ""
        self.driverLicense = car.driver?.licenseNumber ?? ""
        print(owner)
        print(driverLicense)
        
    }
}



struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(make: "", model: "", year: 2020, odometer: 0.0, fuelCapacity: 0, licensePlate: "", owner: "", driverLicense: "")
    }
}


