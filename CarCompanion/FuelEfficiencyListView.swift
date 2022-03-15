//
//  FuelEfficiencyListView.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-01-18.
//

import SwiftUI

struct FuelEfficiencyListView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Driver.entity(), sortDescriptors: []) var driver: FetchedResults<Driver>
    
    var body: some View {
        List {
                        
            ForEach(driver.first!.Cars[driver.first!.Cars.firstIndex(where: {$0.plateNumber == UserDefaults.standard.string(forKey: "CurrentVehicle")})!].dashboard?.fuelEfficiencyArray ?? [], id: \.self) { fuelEfficiency in
                if driver.first!.Cars[driver.first!.Cars.firstIndex(where: {$0.plateNumber == UserDefaults.standard.string(forKey: "CurrentVehicle")})!].dashboard == nil {
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
        
    }
}

struct FuelEfficiencyListView_Previews: PreviewProvider {
    static var previews: some View {
        FuelEfficiencyListView()
    }
}
