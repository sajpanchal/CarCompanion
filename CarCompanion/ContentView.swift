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
    @FetchRequest(entity: CarDashboard.entity(), sortDescriptors: []) var carDashboard: FetchedResults<CarDashboard>
    @Environment(\.scenePhase) var scenePhase
    
    @State var updateOdometer = false
    @State var addFuel = false
    @State var showFuelAlert = true
    @State var selectedTab = 0
    @ObservedObject var locationFetcher = LocationFetcher()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                HomeScreenView(updateOdometer: $updateOdometer, addFuel: $addFuel, showFuelAlert: $showFuelAlert)
                    .frame(alignment: .top)
                    .onAppear(perform: {
                        print("on appear")
                        locationFetcher.start()
                        showFuelAlert = carDashboard.first!.currentFuel == 0.0  ? true  : false
                    })
                    .onChange(of: scenePhase) { newPhase in
                        if newPhase == .active {
                            showFuelAlert = true
                        }
                    }
                    .sheet(isPresented: $updateOdometer,  content: { UpdateOdometer()})
                    .sheet(isPresented: $addFuel, content: {AddFuelView()})
                    .navigationTitle(Text("Home"))
                    if carDashboard.first!.currentFuel == 0.0 && showFuelAlert {
                    AppAlertView(showFuel: $showFuelAlert)
                        .frame(width: 270, height: 200, alignment: .center)
                    }
                    
            }
            .tabItem {
                Image(systemName:"house")
                Text("Home")
            }
            .tag(0)
            SettingsView(make: "", model: "", year: 0, odometer: 0.0, fuelCapacity: 0.0, owner: "", licensePlate: "", driverLicense: "")
                .tabItem {
                    Image(systemName: "gearshape.2.fill")
                    Text("Settings")
                }
                .tag(1)
        }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}





