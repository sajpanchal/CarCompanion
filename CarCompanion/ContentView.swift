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
    @State var updateOdometer = false
    @State var addFuel = false
    @ObservedObject var locationFetcher = LocationFetcher()
   
    var body: some View {
        NavigationView {
             VStack {
                Group {
                    VStack {
                        VStack {
                            SectionView(title: "Odometer Reading", value: carDashboard.first?.odometer ?? 0.0)
                            SectionView(title: "Travel Since last fueling", value: carDashboard.first?.currentTravel ?? 0.0)
                            SectionView(title: "Amount of fuel filled", value: carDashboard.first?.currentFuel ?? 0.0)
                        }
                        .padding(.vertical, 20)
                                                                    
                        AppButton(text: "Filling fuel? Tap it!", color: Color.blue, action: {
                            addFuel = true
                        })
                        AppButton(text: "Update odometer", color: Color.blue, action: {
                            updateOdometer = true
                        })
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
                locationFetcher.start()
            })
            .sheet(isPresented: $updateOdometer,  content: { UpdateOdometer()})
            .sheet(isPresented: $addFuel, content: {AddFuelView()})
            .navigationTitle(Text("Home"))
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}




