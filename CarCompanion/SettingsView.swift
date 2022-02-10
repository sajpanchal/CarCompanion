//
//  SettingsView.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-02-08.
//

import SwiftUI


struct SettingsView: View {
    
    @State var vehicles: [String] = ["Honda Civic", "Toyota Corolla", "Nissan Ultima"]
    @State var vehicle: Int = 0
    
    @State var make: String
    @State var model: String
    @State var year: Int
    @State var odometer: Double
    @State var fuelCapacity: Double
    @State var licensePlate: String
        
    @State var owner: String
    @State var driverLicense: String
    

            
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Form {
                    VehicleSelectionView(vehicles: $vehicles, vehicle: $vehicle)
                    CarDetailsView(make: $make, model: $model, year: $year, odometer: $odometer, fuelCapacity: $fuelCapacity, licensePlate: $licensePlate)
                    
                    DriverDetailsView(owner: $owner, driverLicense: $driverLicense)
                    
                    VStack {
                        AppButton(text: "Save", color: .blue, action: {
                            print("save")
                            
                        }, width: 300, height: 40)
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                }
            }
            .toolbar(content: {
                Button("ADD NEW VEHICLE") {
                    
                }
                .padding(5)
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(20)
            })
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(make: "", model: "", year: 2020, odometer: 0.0, fuelCapacity: 0, licensePlate: "", owner: "", driverLicense: "")
    }
}


