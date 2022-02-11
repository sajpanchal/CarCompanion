//
//  TitleView.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-02-08.
//

import SwiftUI

struct AppTitleView: View {
    var title: String
    var body: some View {
        HStack {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(Color.gray)
                .frame(height: 40, alignment: .leading)
                .padding(.leading, 5)
            
            Spacer()
        }
    }
}


struct AppTitleView_Previews: PreviewProvider {
    static var previews: some View {
        AppTitleView(title: "")
    }
}
