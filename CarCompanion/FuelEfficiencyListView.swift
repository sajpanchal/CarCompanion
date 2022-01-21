//
//  FuelEfficiencyListView.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-01-18.
//

import SwiftUI

struct FuelEfficiencyListView: View {
    var body: some View {
        List {
            VStack {
                HStack {
                    VStack {
                        Text("Travel")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Text("100.23 km")
                            .font(.system(size: 14, weight: .semibold, design: .default))
                            .foregroundColor(.blue)                                                
                    }
                    Spacer()
                    VStack {
                        Text("Fuelling")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Text("100.00 litre")
                            .font(.system(size: 14, weight: .semibold, design: .default))
                            .foregroundColor(.blue)
                    }
                    Spacer()
                    VStack {
                        Text("Efficiency")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Text("10.23 kmpl")
                            .font(.system(size: 14, weight: .semibold, design: .default))
                            .foregroundColor(.blue)
                    }
                }
                Spacer()
                HStack {
                    Spacer()
                    Text(Date(), style: .date)
                        .font(.caption2)
                        .fontWeight(.light)
                        .foregroundColor(.gray)
                    Spacer()
                }
            }
            
        }
    }
}


struct FuelEfficiencyListView_Previews: PreviewProvider {
    static var previews: some View {
        FuelEfficiencyListView()
    }
}
