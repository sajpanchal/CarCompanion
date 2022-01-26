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
    @State var fuel: Double?
    @Binding var showFuel: Bool
    var body: some View {
        VStack {
            Text("Current fuel is not set!")
                .font(.title)
            
            TextField("Enter Current Fuel Amount",value: $fuel, format: .number)
                .padding(5)
                .multilineTextAlignment(.center)
          
            HStack {
            
                AppButton(text: "Add", color: .blue, action: {
                    carDashboard.first!.currentFuel = fuel!
                    CarDashboard.saveContext(viewContext: viewContext)
                }, width: 100, height:40)
                    .disabled(fuel == nil)
                AppButton(text: "Cancel", color: .blue, action: {showFuel = false}, width: 100, height:40)
            }
            
            .padding(10)
        }
      
        .frame(width: 300, height: 200, alignment: .center)
        .background(.yellow)
        .cornerRadius(20)
    }
}

struct AppAlertView_Previews: PreviewProvider {
    static var previews: some View {
        AppAlertView(showFuel: .constant(false))
    }
}
