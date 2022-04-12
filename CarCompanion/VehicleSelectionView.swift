//
//  VehicleSelectionView.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-02-10.
//

import SwiftUI

struct VehicleSelectionView: View {
    @Binding var vehicles: [Car]
    @Binding var vehicle: Car
    var body: some View {
        
        Group {
         
            AppTitleView(title: "SELECTED VEHICLE", font: .title3, weight: .semibold, color: Color.gray)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
            if !vehicles.isEmpty {
                Picker("Select your current vehicle", selection: $vehicle) {
                    ForEach(vehicles, id: \.self) { vehicle in
                        Text((vehicle.make ?? "N/A") + " " +  (vehicle.model ?? "") )
                    }
                }
            }
           
        }
        .onAppear(perform: {
            print("vehicle number: \(vehicle)")
        })
    }
}

struct VehicleSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleSelectionView(vehicles: .constant([]), vehicle: .constant(Car()))
    }
}
