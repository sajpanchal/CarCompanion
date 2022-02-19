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
    var latestYear = { () -> Int in
        let date = Date()
        let calender = Calendar.current
        let component = calender.dateComponents([.year], from: date)
        return component.year!
        
    }()
    
    
    var body: some View {
        VStack {
            
        
            AppSection(value: $make, title: "MAKE", placeholder: "What is the Car Branch?")
            AppSection(value: $model, title: "MODEL", placeholder: "What is the Car Model")
            
            AppSection(value: $licensePlate, title: "LICENSE PLATE #", placeholder: "Car License Plate No.?")
            AppSectionDouble(value: $odometer, title: "ODOMETER (IN KM)", placeholder: "Car Odometer Standing?")
            AppSectionDouble(value: $fuelCapacity, title: "FUEL CAPACITY (IN LITRE)", placeholder: "Car Fuel Capacity?")
            
        }
        AppPicker(value: $year, title: "YEAR", placeholder: "Year of Car Manufacturing")
       
            .listSectionSeparator(.hidden)
            .listSectionSeparatorTint(Color.clear)
            .listRowSeparator(.hidden)
       
        
     
    }
}


struct CarDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CarDetailsView(make: .constant(""), model: .constant(""), year: .constant(0), odometer: .constant(0.0), fuelCapacity: .constant(0.0), licensePlate: .constant(""))
    }
}
