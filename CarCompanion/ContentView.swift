//
//  ContentView.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-01-08.
//

import SwiftUI
import CoreData


struct ContentView: View {

    @State var totalTravel: Double?
    @State var currentTravel: Double? = 123.22
    @State var fuel: Double? = 10.20
    
    @ObservedObject var locationFetcher = LocationFetcher()
   
    var body: some View {
        NavigationView {
             VStack {
                Group {
                    VStack {
                        VStack {
                            
                            SectionView(title: "Odometer Reading", value: $totalTravel)
                            SectionView(title: "Travel Since last fueling", value: .constant(0.0), constValue: locationFetcher.distance)
                            SectionView(title: "Amount of fuel filled", value: .constant(0.0), constValue: fuel)
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
            .navigationTitle(Text("Home"))
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}



