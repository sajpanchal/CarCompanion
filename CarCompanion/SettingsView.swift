//
//  SettingsView.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-02-08.
//

import SwiftUI


struct SettingsView: View {
    @State var make: String
    @State var model: String
    @State var year: Int
    @State var odometer: Double
    @State var fuelCapacity: Double
    @State var owner: String
    @State var licensePlate: String
    @State var driverLicense: String
    var latestYear = { () -> Int in
        let date = Date()
        let calender = Calendar.current
        let component = calender.dateComponents([.year], from: date)
        return component.year!
        
    }()
    
    var body: some View {
        NavigationView {
        
            VStack {
                Spacer()
                
                Form {
                    
                    
                    Group {
                        VStack {
                            Text("CAR DETAILS")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.secondary)
                            
                        }
                        .padding(.top, 20)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets())
                      
                        Section("Make") {
                            TextField("What brand is this car?", text: $make)
                        }
                        Section("Model") {
                            TextField("What model is this car?", text: $model)
                        }
                        Section("Year") {
                            Picker("What year is your car make?", selection: $year) {
                                ForEach(1900...latestYear, id: \.self) {
                                    Text(String($0))
                                }
                            }
                        }
                        Section("License plate") {
                            TextField("What is the Car License Plate Number", text: $licensePlate)
                        }
                        Section("ODOMETER (in KM)") {
                            TextField("What is your car odometer reading status?", value: $odometer, format: .number)
                        }
                        Section("Fuel Capacity") {
                            TextField("What is the car fuel capacity?", value:$fuelCapacity, format: .number)
                        }
                    }
                    Group {
                        VStack {
                            Text("PERSONAL DETAILS")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.secondary)
                        }
                        .padding(.top, 15)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets())
                        Section("Owner's Full Name") {
                            TextField("Who is the car Owner?", text: $owner)
                        }
                        Section("Driver's License") {
                            TextField("Enter Your Driver's Lincense Number", text: $driverLicense)
                        }
                    }
                    VStack {
                        Button {
                            print("save")
                        } label: {
                            HStack {
                                Spacer()
                                Text("Save")
                                Spacer()
                            }
                            .frame(height: 30, alignment: .center)
                            
                        }
                        .background(.gray)
                        .cornerRadius(100)
                        .padding(.bottom, 10)
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                    
                   
                        
                    
                    
                }
            }
           
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(make: "", model: "", year: 2020, odometer: 0.0, fuelCapacity: 0, owner: "", licensePlate: "", driverLicense: "")
    }
}
