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
//    @ObservedObject var locationFetcher = LocationFetcher()

    var body: some View {
        VStack {
            Group {
                VStack {
                    AppTitleView(title: "DASHBOARD SUMMARY", font: .title3, weight: .semibold, color: .gray)
                    SectionView(title: "Odometer Reading", value: driver.first!.Cars[driver.first!.Cars.firstIndex(where: {$0.plateNumber == UserDefaults.standard.string(forKey: "CurrentVehicle")})!].dashboard?.odometer ?? 0.0, color: .pink)
                    
                    HStack {
                        SectionView(title: "Current Cycle Travel", value: driver.first!.Cars[driver.first!.Cars.firstIndex(where: {$0.plateNumber == UserDefaults.standard.string(forKey: "CurrentVehicle")})!].dashboard?.currentTravel ?? 0.0, color: .green)
                        SectionView(title: "Current Cycle Fuel", value: driver.first!.Cars[driver.first!.Cars.firstIndex(where: {$0.plateNumber == UserDefaults.standard.string(forKey: "CurrentVehicle")})!].dashboard?.currentFuel ?? 0.0, color: .orange)
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
            AppTitleView(title: "FUEL EFFICIENCY HISTORY", font: .title3, weight: .semibold, color: .gray)
            
            FuelEfficiencyListView()
        }
    }
}
    

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(updateOdometer: .constant(false), addFuel: .constant(false), showFuelAlert: .constant(false))
    }
}

