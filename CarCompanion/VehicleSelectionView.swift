//
//  VehicleSelectionView.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-02-10.
//

import SwiftUI

struct VehicleSelectionView: View {
    @Binding var vehicles: [String]
    @Binding var vehicle: Int
    var body: some View {
        
        Group {
            TitleView(title: "SELECTED VEHICLE")
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
            Picker("Select your current vehicle", selection: $vehicles[vehicle]) {
                ForEach(vehicles, id: \.self) {
                    Text($0)
                }
            }
        }
    }
}

struct VehicleSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleSelectionView(vehicles: .constant([]), vehicle: .constant(0))
    }
}
