//
//  HomeScreenView.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-02-08.
//

import SwiftUI

struct HomeScreenView: View {
    @Binding var updateOdometer: Bool
    @Binding var addFuel: Bool
    @Binding var showFuelAlert: Bool
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: CarDashboard.entity(), sortDescriptors: []) var carDashboard: FetchedResults<CarDashboard>
   
    var body: some View {
        VStack {
            Group {
                VStack {
                    TitleView(title: "DASHBOARD SUMMARY")
                    SectionView(title: "Odometer Reading", value: carDashboard.first?.odometer ?? 0.0, color: .pink)
                    
                    HStack {
                        SectionView(title: "Current Cycle Travel", value: carDashboard.first?.currentTravel ?? 0.0, color: .green)
                        SectionView(title: "Current Cycle Fuel", value: carDashboard.first?.currentFuel ?? 0.0, color: .orange)
                    }
                    .padding(.top, 5)
                    
                    AppButton(text: "Filling fuel? Tap it!", color: Color.blue, action: {
                        addFuel = true
                    }, width: 300, height: 40)
                    AppButton(text: "Update odometer", color: Color.blue, action: {
                        updateOdometer = true
                    }, width: 300, height: 40)
                }
                .padding(5)
            }
            Spacer()
            TitleView(title: "FUEL EFFICIENCY HISTORY")                        
            FuelEfficiencyListView()
        }
    }
}
    

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(updateOdometer: .constant(false), addFuel: .constant(false), showFuelAlert: .constant(false))
    }
}

