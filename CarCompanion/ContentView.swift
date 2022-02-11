//
//  ContentView.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-01-08.
//

import SwiftUI
import CoreData


struct ContentView: View {

    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Driver.entity(), sortDescriptors: []) var driver: FetchedResults<Driver>
    @Environment(\.scenePhase) var scenePhase
    
    @State var updateOdometer = false
    @State var addFuel = false
    @State var showFuelAlert = true
    @State var selectedTab = 0
    @ObservedObject var locationFetcher = LocationFetcher()

    var body: some View {
        if driver.isEmpty {
            SettingsView(make: "", model: "", year: 0, odometer: 0.0, fuelCapacity: 0.0, licensePlate: "", owner: "", driverLicense: "")
        }
        
        else {
            TabView(selection: $selectedTab) {
                NavigationView {
                    HomeScreenView(updateOdometer: $updateOdometer, addFuel: $addFuel, showFuelAlert: $showFuelAlert)
                        .frame(alignment: .top)
                        .onAppear(perform: {
                            print("on appear")
                            locationFetcher.start()
                            /*showFuelAlert = carDashboard.first!.currentFuel == 0.0  ? true  : false*/
                        })
                        .onChange(of: scenePhase) { newPhase in
                            if newPhase == .active {
                                showFuelAlert = true
                            }
                        }
                        .sheet(isPresented: $updateOdometer,  content: { UpdateOdometer()})
                        .sheet(isPresented: $addFuel, content: {AddFuelView()})
                        .navigationTitle(Text("Home"))
                       /* if carDashboard.first!.currentFuel == 0.0 && showFuelAlert {
                        AppAlertView(showFuel: $showFuelAlert)
                            .frame(width: 270, height: 200, alignment: .center)
                        }*/
                        
                }
                .tabItem {
                    Image(systemName:"house")
                    Text("Home")
                }
                .tag(0)
                SettingsView(make: "", model: "", year: 0, odometer: 0.0, fuelCapacity: 0.0, licensePlate: "", owner: "", driverLicense: "")
                    .tabItem {
                        Image(systemName: "gearshape.2.fill")
                        Text("Settings")
                    }
                    .tag(1)
            }
                    
        }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}





/*
 extension FuelEfficiency {

     @nonobjc public class func fetchRequest() -> NSFetchRequest<FuelEfficiency> {
         return NSFetchRequest<FuelEfficiency>(entityName: "FuelEfficiency")
     }

     @NSManaged public var efficiency: Double
     @NSManaged public var fuel: Double
     @NSManaged public var timeStamp: Date?
     @NSManaged public var travel: Double
     @NSManaged public var carDashboard: CarDashboard?
     
     public var TimeStamp: String {
         let dateFormatter = DateFormatter()
         dateFormatter.dateStyle = .medium
         dateFormatter.timeStyle = .long
         return dateFormatter.string(from: timeStamp!)
     }
     static func saveContext(viewContext: NSManagedObjectContext) {
         do {
             try viewContext.save()
             print("fuel efficiency updated!")
         }
         catch {
             print("Error saving fuelEfficiency context!")
         }
     }

 }

 extension FuelEfficiency : Identifiable {

 }

 */

/*
 extension CarDashboard {

     @nonobjc public class func fetchRequest() -> NSFetchRequest<CarDashboard> {
         return NSFetchRequest<CarDashboard>(entityName: "CarDashboard")
     }

     @NSManaged public var currentFuel: Double
     @NSManaged public var currentTravel: Double
     @NSManaged public var odometer: Double
     @NSManaged public var fuelEfficiency: NSSet?
     
     public var fuelEfficiencyArray: [FuelEfficiency] {
         let set = fuelEfficiency as? Set<FuelEfficiency> ?? []
         return set.sorted {
             $0.timeStamp! > $1.timeStamp!
         }
     }
     
     static func saveContext(viewContext: NSManagedObjectContext) {
         do {
             try viewContext.save()
           //  print("car dashboard updated!")
         }
         catch {
             print("save failed")
         }
     }
     static func fetchData(viewContext: NSManagedObjectContext) -> CarDashboard?{
         var carDashboard: CarDashboard?
         do {
             carDashboard = try viewContext.fetch(Self.fetchRequest()).first
         }
         catch {
             print("couldn't fetch it.")
         }
         return carDashboard
     }

 }

 // MARK: Generated accessors for fuelEfficiency
 extension CarDashboard {

     @objc(addFuelEfficiencyObject:)
     @NSManaged public func addToFuelEfficiency(_ value: FuelEfficiency)

     @objc(removeFuelEfficiencyObject:)
     @NSManaged public func removeFromFuelEfficiency(_ value: FuelEfficiency)

     @objc(addFuelEfficiency:)
     @NSManaged public func addToFuelEfficiency(_ values: NSSet)

     @objc(removeFuelEfficiency:)
     @NSManaged public func removeFromFuelEfficiency(_ values: NSSet)

 }

 extension CarDashboard : Identifiable {

 }

 */
