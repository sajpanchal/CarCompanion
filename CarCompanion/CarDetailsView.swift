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
    @FocusState var focus: Bool
    
    
    
    var body: some View {
        VStack {
            AppTitleView(title: "CAR DETAILS")
                .padding(.top, 20)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
        
            AppSection(value: $make, title: "Make", placeholder: "What brand is this car?")
            AppSection(value: $model, title: "Model", placeholder: "What model is this car?")
            AppPicker(value: $year, title: "Year", placeholder: "What year is your car make?")
            
            AppSection(value: $licensePlate, title: "License plate", placeholder: "What is the Car License Plate Number")
            AppSectionDouble(value: $odometer, title: "ODOMETER (in KM)", placeholder: "What is your car odometer reading status?")
            AppSectionDouble(value: $fuelCapacity, title: "Fuel Capacity (in Litre)", placeholder: "What is the car fuel capacity?")
            
        }
        
     
    }
}


struct CarDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CarDetailsView(make: .constant(""), model: .constant(""), year: .constant(0), odometer: .constant(0.0), fuelCapacity: .constant(0.0), licensePlate: .constant(""))
    }
}
