//
//  AppAlertView.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-01-26.
//

import SwiftUI

struct AppAlertView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: CarDashboard.entity(), sortDescriptors: []) var carDashboard: FetchedResults<CarDashboard>
    @FetchRequest(entity: Driver.entity(), sortDescriptors: []) var driver: FetchedResults<Driver>
    @State var fuel: Double?
    @Binding var showFuel: Bool
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack {
            Text("Last fuel amount is not set!")
                .font(.title3)
                .fontWeight(.black)
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .padding(.bottom, 15)
                .padding(.top, 15)
               Divider()
            
            TextField("Enter Last Fuel Amount",value: $fuel, format: .number)
                .frame(width: 275, height: 35, alignment: .center)
                .multilineTextAlignment(.center)
                .background(colorScheme == .dark ? .black : .white)
                .cornerRadius(10)
                .padding(.top, 10)
         
            HStack {
            
                AppButton(text: "Add", color: .blue, action: {
                    driver.first!.Cars[driver.first!.Cars.firstIndex(where: {$0.plateNumber == UserDefaults.standard.string(forKey: "CurrentVehicle")})!].dashboard?.currentFuel = fuel!
                    Driver.saveContext(viewContext: viewContext)
                    showFuel = false
                }, width: 120, height:30)
                    .disabled(fuel == nil)
                Divider()
                AppButton(text: "Cancel", color: .blue, action: {showFuel = false}, width: 120, height:30)
            }
            
            .padding(.top, 20)
        }
      
        .frame(width: 325, height: 200, alignment: .center)
        .background(colorScheme == .dark ? Color(red: 0.274, green: 0.274, blue: 0.274, opacity: 1): Color(red: 1.0-0.274, green: 1.0-0.274, blue: 1.0-0.274, opacity: 1))
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

struct AppAlertView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AppAlertView(showFuel: .constant(false))
            AppAlertView(showFuel: .constant(false))
        }
    }
}
