//
//  ServiceForm.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-04-08.
//

import SwiftUI

struct ServiceForm: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button("Save", action: {
                            dismiss()
                        })
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button("Discard", action: {
                            dismiss()
                        })
                    }
                    
                }
        }
      
           
    }
    
}

struct ServiceForm_Previews: PreviewProvider {
    static var previews: some View {
        ServiceForm()
    }
}
