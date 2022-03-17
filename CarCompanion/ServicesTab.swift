//
//  ServicesTab.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-03-17.
//

import SwiftUI

struct ServicesTab: View {
    var body: some View {
        NavigationView {
           VStack{
                AppButton(text: "Add New Entry", color: .blue, action: {
                    
                }, width: 300, height: 40)
                   .padding(.vertical, 30)
               
             AppTitleView(title: "SERVICES/REPAIRS HISTORY")
               List {
                   Text("1")
                   Text("1")
                   Text("1")
               }
                    
            } .navigationTitle("Services/Repairs")
               
        }
       
           
        
       
    }
}

struct ServicesTab_Previews: PreviewProvider {
    static var previews: some View {
        ServicesTab()
    }
}
