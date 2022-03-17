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
    @FetchRequest(entity: Driver.entity(), sortDescriptors: []) var driver: FetchedResults<Driver>
    @State var fuelAmount: Double = 0.0
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                
                AppSectionDouble(value: $fuelAmount, title: "ADD FUEL TO FULLY FILL THE GAS TANK", placeholder: "How much fuel have you filled?")
                    .padding(.horizontal)
           
                AppButton(text: "Add Fuel", color: Color.blue, action: {
                    if driver.first!.Cars[driver.first!.Cars.firstIndex(where: {$0.plateNumber == UserDefaults.standard.string(forKey: "CurrentVehicle")})!].dashboard != nil {
                        print("updating fuel efficiency!")
                        DispatchQueue.main.async {
                            updateFuelEfficiency()
                        }
                       
                    }
                    DispatchQueue.main.async {
                       
                        resetCurrentTravel()
                        CarDashboard.saveContext(viewContext: viewContext)
                      
                    }
                   
                    dismiss()
                    
                }, width: 300, height: 40).disabled(fuelAmount == 0.0)
                    .padding()
                Text("Note: In order to calculate the actual fuel consumption, it is assumed that you are filling up the gas in your car up until the gas tank is full.")
                    .foregroundColor(Color.red)
                    .multilineTextAlignment(.leading)
                    .font(.footnote)
                Spacer()
            }
            .onAppear(perform: {
               
                
           //     locationFetcher.stop()
                print("-------add fuel view before--------")
                print("travel: ", driver.first!.Cars[driver.first!.Cars.firstIndex(where: {$0.plateNumber == UserDefaults.standard.string(forKey: "CurrentVehicle")})!].dashboard!.currentTravel)
                print("fuel: ", driver.first!.Cars[driver.first!.Cars.firstIndex(where: {$0.plateNumber == UserDefaults.standard.string(forKey: "CurrentVehicle")})!].dashboard!.currentFuel)
                print("odometer: ", driver.first!.Cars[driver.first!.Cars.firstIndex(where: {$0.plateNumber == UserDefaults.standard.string(forKey: "CurrentVehicle")})!].dashboard!.odometer)
            })
            .onDisappear(perform: {
                print("-------add fuel view after--------")
                print("travel: ", driver.first!.Cars[driver.first!.Cars.firstIndex(where: {$0.plateNumber == UserDefaults.standard.string(forKey: "CurrentVehicle")})!].dashboard!.currentTravel)
                print("fuel: ", driver.first!.Cars[driver.first!.Cars.firstIndex(where: {$0.plateNumber == UserDefaults.standard.string(forKey: "CurrentVehicle")})!].dashboard!.currentFuel)
                print("odometer: ", driver.first!.Cars[driver.first!.Cars.firstIndex(where: {$0.plateNumber == UserDefaults.standard.string(forKey: "CurrentVehicle")})!].dashboard!.odometer)
                print("---array of fuel Efficiency----")
                for item in driver.first!.Cars[driver.first!.Cars.firstIndex(where: {$0.plateNumber == UserDefaults.standard.string(forKey: "CurrentVehicle")})!].dashboard!.fuelEfficiencyArray {
                    print("travel: ", item.travel)
                    print("fuel: ", item.fuel)
                    print("odometer: ", item.efficiency)
                }
               // locationFetcher.start()
            })
            .navigationTitle("At the Fuel Station")
        }
    }
    func updateFuelEfficiency() {
       
        let fuelEfficiency = FuelEfficiency(context: viewContext)
        
        let dashboard = driver.first!.Cars[driver.first!.Cars.firstIndex(where: {$0.plateNumber == UserDefaults.standard.string(forKey: "CurrentVehicle")})!].dashboard!
        
        fuelEfficiency.fuel = dashboard.currentFuel
        fuelEfficiency.travel = dashboard.currentTravel
        fuelEfficiency.efficiency = dashboard.currentTravel/dashboard.currentFuel
        fuelEfficiency.timeStamp = Date()
      
        driver.first!.Cars[driver.first!.Cars.firstIndex(where: {$0.plateNumber == UserDefaults.standard.string(forKey: "CurrentVehicle")})!].dashboard?.addToFuelEfficiency(fuelEfficiency)
            
        try? viewContext.save()
      
    }
    
    func resetCurrentTravel() {
        
         if driver.first!.Cars[driver.first!.Cars.firstIndex(where: {$0.plateNumber == UserDefaults.standard.string(forKey: "CurrentVehicle")})!].dashboard == nil {
             print("car dashboard is empty.")
             let newEntry = CarDashboard(context: viewContext)
             newEntry.currentFuel = fuelAmount
             newEntry.currentTravel = 0.0
             newEntry.odometer = 0.0
         }
         else {
             print("reseting car dashboard.")
         
             print("last odometer is: ",driver.first!.Cars[driver.first!.Cars.firstIndex(where: {$0.plateNumber == UserDefaults.standard.string(forKey: "CurrentVehicle")})!].dashboard!.odometer)
             driver.first!.Cars[driver.first!.Cars.firstIndex(where: {$0.plateNumber == UserDefaults.standard.string(forKey: "CurrentVehicle")})!].dashboard?.currentFuel = fuelAmount
             driver.first!.Cars[driver.first!.Cars.firstIndex(where: {$0.plateNumber == UserDefaults.standard.string(forKey: "CurrentVehicle")})!].dashboard?.currentTravel = 0.0
            
           
         }             
     }
}

struct AddFuelView_Previews: PreviewProvider {
    static var previews: some View {
        AddFuelView()
    }
}

