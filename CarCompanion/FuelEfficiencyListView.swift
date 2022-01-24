//
//  FuelEfficiencyListView.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-01-18.
//

import SwiftUI

struct FuelEfficiencyListView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: CarDashboard.entity(), sortDescriptors: []) var carDashboard: FetchedResults<CarDashboard>
    @FetchRequest(entity: FuelEfficiency.entity(), sortDescriptors: []) var fuelEfficiencies: FetchedResults<FuelEfficiency>
    var body: some View {
        List {
                        
            ForEach(carDashboard.first?.fuelEfficiencyArray ?? [], id: \.self) { fuelEfficiency in
                if carDashboard.first == nil {
                    VStack {
                      Text("No entries found!")
                    }
                }
                else {
                    VStack {
                        HStack {
                            VStack {
                                Text("Travel")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                                Text("\(fuelEfficiency.travel, specifier: "%.2f") km")
                                    .font(.system(size: 14, weight: .semibold, design: .default))
                                    .foregroundColor(.blue)
                            }
                            Spacer()
                            VStack {
                                Text("Fuelling")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                                Text("\(fuelEfficiency.fuel, specifier: "%.2f") litre")
                                    .font(.system(size: 14, weight: .semibold, design: .default))
                                    .foregroundColor(.blue)
                            }
                            Spacer()
                            VStack {
                                Text("Efficiency")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                                Text("\(fuelEfficiency.efficiency, specifier: "%.2f") kmpl")
                                    .font(.system(size: 14, weight: .semibold, design: .default))
                                    .foregroundColor(.blue)
                            }
                        }
                        Spacer()
                        HStack {
                            Spacer()
                            Text(fuelEfficiency.TimeStamp)
                                .font(.caption2)
                                .fontWeight(.light)
                                .foregroundColor(.gray)
                            Spacer()
                        }
                    }
                }
            }
            
        }
        .onAppear(perform: {
            print("on Appear method from list")
            print(carDashboard.first!.fuelEfficiencyArray)
            for entry in fuelEfficiencies{
              
                print("fuel:", entry.fuel)
                print("travel:", entry.travel)
                print("efficiency:", entry.efficiency)
            }
        })
    }
}


struct FuelEfficiencyListView_Previews: PreviewProvider {
    static var previews: some View {
        FuelEfficiencyListView()
    }
}
