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
    @FetchRequest(entity: Driver.entity(), sortDescriptors: []) var driver: FetchedResults<Driver>
    @ObservedObject var locationFetcher = LocationFetcher()

    var body: some View {
        VStack {
            Group {
                VStack {
                    AppTitleView(title: "DASHBOARD SUMMARY")
                    SectionView(title: "Odometer Reading", value: locationFetcher.driver?.Cars[locationFetcher.index ?? 0].dashboard?.odometer ?? 0.0, color: .pink)
                    
                    HStack {
                        SectionView(title: "Current Cycle Travel", value: locationFetcher.driver?.Cars[locationFetcher.index ?? 0].dashboard?.currentTravel ?? 0.0, color: .green)
                        SectionView(title: "Current Cycle Fuel", value: locationFetcher.driver?.Cars[locationFetcher.index ?? 0].dashboard?.currentFuel ?? 0.0, color: .orange)
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
            AppTitleView(title: "FUEL EFFICIENCY HISTORY")
            FuelEfficiencyListView()
        }
    }
}
    

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(updateOdometer: .constant(false), addFuel: .constant(false), showFuelAlert: .constant(false))
    }
}

