//
//  AppAlertView.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-01-26.
//

import SwiftUI

struct AppAlertView: View {
    @State var fuel: String = ""
    var body: some View {
        VStack {
            Text("Add Last Fuel Amount")
                .font(.title)
            
            TextField("Enter Current Fuel Amount", text: $fuel)
                .padding(5)
                .multilineTextAlignment(.center)
          
            HStack {
            
                AppButton(text: "Add", color: .blue, action: {}, width: 100, height:40)
                AppButton(text: "Cancel", color: .blue, action: {}, width: 100, height:40)
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
        AppAlertView()
    }
}
