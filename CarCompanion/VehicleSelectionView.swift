//
//  VehicleSelectionView.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-02-10.
//

import SwiftUI

struct VehicleSelectionView: View {
    @Binding var vehicles: [Car]
    @Binding var vehicle: Int
    var body: some View {
        
        Group {
            AppTitleView(title: "SELECTED VEHICLE")
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
            Picker("Select your current vehicle", selection: $vehicles[vehicle]) {
                ForEach(vehicles, id: \.self) { vehicle in
                    Text((vehicle.model ?? "n/a") + (vehicle.make ?? ""))
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
