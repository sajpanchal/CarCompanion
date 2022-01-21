//
//  SectionView.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-01-18.
//

import SwiftUI

struct SectionView: View {
    var title: String
    var value: Double
   
    
    var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.semibold)
                .font(.footnote)
            Spacer()
           
            
                Text("\(value, specifier: "%.2f")")
                    .font(.system(size: 14, weight: .bold, design: .default))
                    .foregroundColor(Color.blue)
            
            if(title == "Amount of fuel filled") {
                Text("litre")
                    .font(.system(size: 14, weight: .bold, design: .default))
                    .foregroundColor(Color.blue)
            }
            else if (title == "Odometer Reading") {
                Text("km")
                    .font(.system(size: 14, weight: .bold, design: .default))
                    .foregroundColor(Color.blue)
            }
            else if(title == "Travel Since last fueling") {
                Text("km")
                    .font(.system(size: 14, weight: .bold, design: .default))
                    .foregroundColor(Color.blue)
            }
            
            
        }
        .padding(10)
        .background(Color(red: 0.75, green: 0.75, blue: 0.75, opacity: 1))
        .cornerRadius(10)
    }
}


struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(title: "", value: 0.0)
    }
}
