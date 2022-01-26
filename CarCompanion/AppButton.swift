//
//  AppButton.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-01-21.
//

import SwiftUI

struct AppButton: View {
    var text: String
    var color: Color
    var action: () -> ()
    var width: CGFloat
    var height: CGFloat
    var body: some View {
        Button {
            action()
        }
    label: {
        HStack {
            Spacer()
            Text(text)
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
        }
        .frame(width: width, height: height, alignment: .center)
    }
    .background(color)
    .cornerRadius(50)
    }
    
}


struct AppButton_Previews: PreviewProvider {
    static var previews: some View {
        AppButton(text: "", color: .clear, action: {}, width: 0, height: 0)
    }
}
