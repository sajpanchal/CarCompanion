//
//  ServicesTab.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-03-17.
//

import SwiftUI

struct ServicesTab: View {
    @State var serviceView: Bool = false
    var body: some View {
        NavigationView {
           VStack{
                AppButton(text: "Add New Entry", color: .blue, action: {
                    serviceView = true
                }, width: 300, height: 40)
                   .padding(.vertical, 30)
                   
               
             AppTitleView(title: "SERVICES/REPAIRS HISTORY")
               VStack {
                   List {
                       Text("1")
                       Text("1")
                       Text("1")
                   }
               }
               .frame(width: 400, height: 400, alignment: .center)
               .background(Color.red)
              
          
                    
            }
           .sheet(isPresented: $serviceView) {
               ServiceForm()
           }.navigationTitle("Services/Repairs")
               
        }
       
           
        
       
    }
}

struct ServicesTab_Previews: PreviewProvider {
    static var previews: some View {
        ServicesTab()
    }
}
