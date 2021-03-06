//
//  ServiceRecordsList.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-04-19.
//

import SwiftUI

struct ServiceRecordsList: View {
    var serviceRecord: ServiceRecords
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Location")
                        .font(.system(size: 14, weight: .semibold, design: .default))
                        .foregroundColor(.gray)
                        .frame(width: 200, alignment: .leading)
                    Text(serviceRecord.shopName!)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .frame(width: 200, alignment: .leading)
                }
              
                Spacer()
                VStack {
                    Text("Total Cost")
                        .font(.system(size: 14, weight: .semibold, design: .default))
                        .foregroundColor(.gray)
                        .frame(width: 100, alignment: .trailing)
                    Text(serviceRecord.totalCost, format: .currency(code: Locale.current.currencyCode!))
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                        .frame(width: 100, alignment: .trailing)
                }
            }
            Spacer()
            Text(serviceRecord.DateOfService)
                .font(.caption2)
                .fontWeight(.light)
                .foregroundColor(.gray)
        }
    }
}


struct ServiceRecordsList_Previews: PreviewProvider {
    static var previews: some View {
        ServiceRecordsList(serviceRecord: ServiceRecords())
    }
}
