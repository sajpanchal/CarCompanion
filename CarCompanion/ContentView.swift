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
    @ObservedObject var locationFetcher = LocationFetcher()
   
    var body: some View {
        NavigationView {
            
            ZStack {
               
                VStack {
                    Group {
                        VStack {
                            SectionView(title: "Odometer Reading", value: carDashboard.first?.odometer ?? 0.0, color: .pink )
                            
                            HStack {
                                SectionView(title: "Current Cycle Travel", value: carDashboard.first?.currentTravel ?? 0.0, color: .green )
                                SectionView(title: "Current Cycle Fuel", value: carDashboard.first?.currentFuel ?? 0.0, color: .orange )
                            }
                            .padding(.top, 5)
                                                                        
                            AppButton(text: "Filling fuel? Tap it!", color: Color.blue, action: {
                                addFuel = true
                            }, width: 300, height: 40)
                            AppButton(text: "Update odometer", color: Color.blue, action: {
                                updateOdometer = true
                            }, width: 300, height: 40)
                        }
                        .padding(5)
                         }
                     Spacer()
                     HStack {
                     Text("FUEL EFFICIENCY HISTORY")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.gray)
                        .frame(height: 40, alignment: .leading)
                        .padding(.leading, 5)
                         Spacer()
                     }
                  
                        FuelEfficiencyListView()
                    
                }
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
               // if carDashboard.first!.currentFuel == 0.0 && showFuelAlert {
                AppAlertView(showFuel: $showFuelAlert)
                    .frame(width: 270, height: 200, alignment: .center)
             //   }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}




