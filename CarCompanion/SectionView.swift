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
    var color: Color
    var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text(title)
                    .font(.system(size: 12, weight: .black, design: .default))
                    .foregroundColor(.black)
                Spacer()
                Text("\(value, specifier: "%.2f")")
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .foregroundColor(Color.black)
                if(title == "Current Cycle Fuel") {
                    Text("litre")
                        .font(.system(size: 14, weight: .bold, design: .default))
                        .foregroundColor(Color.black)
                }
                else if (title == "Odometer Reading") {
                    Text("km")
                        .font(.system(size: 14, weight: .bold, design: .default))
                        .foregroundColor(Color.black)
                }
                else if (title == "Current Cycle Travel") {
                    Text("km")
                        .font(.system(size: 14, weight: .bold, design: .default))
                        .foregroundColor(Color.black)
                }
            }
            Spacer()
        }
        .padding(5)
        .background(color)
        .cornerRadius(10)
    }
}


struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(title: "", value: 0.0, color: .gray)
    }
}
