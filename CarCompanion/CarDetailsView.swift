//
//  CarDetailsView.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-02-09.
//

import SwiftUI

struct CarDetailsView: View {
    @Binding var make: String
    @Binding var model: String
    @Binding var year: Int
    @Binding var odometer: Double
    @Binding var fuelCapacity: Double
    @Binding var licensePlate: String
    
    var latestYear = { () -> Int in
        let date = Date()
        let calender = Calendar.current
        let component = calender.dateComponents([.year], from: date)
        return component.year!
        
    }()
    
    var body: some View {
        Group {
            AppTitleView(title: "CAR DETAILS")
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
                    ForEach((1900...latestYear).reversed(), id: \.self) {
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
            Section("Fuel Capacity (in Litre)") {
                TextField("What is the car fuel capacity?", value:$fuelCapacity, format: .number)
            }
        }
    }
}


struct CarDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CarDetailsView(make: .constant(""), model: .constant(""), year: .constant(0), odometer: .constant(0.0), fuelCapacity: .constant(0.0), licensePlate: .constant(""))
    }
}
