//
//  VehicleSelectionView.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-02-10.
//

import SwiftUI

struct VehicleSelectionView: View {
    var vehicles: [String] = ["Honda Civic", "Toyota Corrolla", "Nissan Ultima"]
    @State var vehicle: String = "Honda Civic"
    var body: some View {
        
        Group {
            TitleView(title: "SELECTED VEHICLE")
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
            Picker("Select your current vehicle", selection: $vehicle) {
                ForEach(vehicles, id: \.self) {
                    Text($0)
                }
            }
        }
    }
}

struct VehicleSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleSelectionView()
    }
}
