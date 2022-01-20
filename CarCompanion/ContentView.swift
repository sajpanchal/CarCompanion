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
                                                                    
                        Button {
                            print("hello")
                        }
                    label: {
                        HStack {
                            Spacer()
                            Text("Fueling at the gas station?")
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .frame(width: 300, height: 30, alignment: .center)
                    }
                    .background(Color.blue)
                    .cornerRadius(50)
                        
                        Button {
                            updateOdometer = true
                        }
                    label: {
                        HStack {
                            Spacer()
                            Text("Update odometer")
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .frame(width: 300, height: 30, alignment: .center)
                    }
                    .background(Color.blue)
                    .cornerRadius(50)
                       
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
            .navigationTitle(Text("Home"))
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}



