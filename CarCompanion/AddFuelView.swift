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
    @State var fuelAmount: Double = 0.0
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                
                AppSectionDouble(value: $fuelAmount, title: "ADD FUEL AMOUNT", placeholder: "How much fuel have you filled?")
           
                AppButton(text: "Add Fuel", color: Color.blue, action: {
                    if !carDashboard.isEmpty {
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
                Spacer()
            }
            .onAppear(perform: {
               
                
           //     locationFetcher.stop()
                print("-------add fuel view before--------")
                print("travel: ", carDashboard.first!.currentTravel)
                print("fuel: ", carDashboard.first!.currentFuel)
                print("odometer: ", carDashboard.first!.odometer)
            })
            .onDisappear(perform: {
                print("-------add fuel view after--------")
                print("travel: ", carDashboard.first!.currentTravel)
                print("fuel: ", carDashboard.first!.currentFuel)
                print("odometer: ", carDashboard.first!.odometer)
                print("---array of fuel Efficiency----")
                for item in carDashboard.first!.fuelEfficiencyArray {
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
        
        fuelEfficiency.fuel = carDashboard.first!.currentFuel
        fuelEfficiency.travel = carDashboard.first!.currentTravel
        fuelEfficiency.efficiency = fuelEfficiency.travel/fuelEfficiency.fuel
        fuelEfficiency.timeStamp = Date()
        fuelEfficiency.carDashboard = carDashboard.first!

       /* print("---car dashboard before updating fuel efficiency-----")
        print("travel: ", carDashboard.first!.currentTravel)
        print("fuel: ", carDashboard.first!.currentFuel)
        print("odometer: ", carDashboard.first!.odometer)*/
        try? viewContext.save()
       /*print("---car dashboard after updating fuel efficiency-----")
        print("travel: ", carDashboard.first!.currentTravel)
        print("fuel: ", carDashboard.first!.currentFuel)
        print("odometer: ", carDashboard.first!.odometer)*/
    }
    
    func resetCurrentTravel() {
        
         if carDashboard.isEmpty {
             print("car dashboard is empty.")
             let newEntry = CarDashboard(context: viewContext)
             newEntry.currentFuel = fuelAmount
             newEntry.currentTravel = 0.0
             newEntry.odometer = 0.0
         }
         else {
             print("reseting car dashboard.")
           /*  print("last travel is: ", carDashboard.first?.currentTravel)
             print("last odometer is: ",carDashboard.first?.odometer )*/
             carDashboard.first?.currentFuel = fuelAmount
             carDashboard.first?.currentTravel = 0.0
            
             /*print("current fuel is: ",carDashboard.first?.currentFuel)
             print("current travel is: ",carDashboard.first?.currentTravel)*/
         }             
     }
}

struct AddFuelView_Previews: PreviewProvider {
    static var previews: some View {
        AddFuelView()
    }
}

