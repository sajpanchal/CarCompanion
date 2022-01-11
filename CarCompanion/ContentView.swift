//
//  ContentView.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-01-08.
//

import SwiftUI
import CoreData


struct ContentView: View {

    @State var totalTravel: Double?
    var body: some View {
        NavigationView {
             VStack {
                Group {
                    VStack {
                        VStack {
                            HStack {
                                Text("Odometer Reading")
                                    .fontWeight(.semibold)
                                    .font(.footnote)
                                Spacer()
                                TextField("Tap to Set it", value: $totalTravel, format: .number)
                                    .font(.system(size: 14, weight: .bold, design: .default))
                                    .multilineTextAlignment(.trailing)
                                    .foregroundColor(Color.blue)
                                if(totalTravel != nil) {
                                Text("km")
                                        .font(.system(size: 14, weight: .bold, design: .default))
                                        .foregroundColor(Color.blue)
                                }

                                   
                            }
                            .padding(10)
                            .background(Color(red: 0.75, green: 0.75, blue: 0.75, opacity: 1))
                            .cornerRadius(10)
                         
                            HStack {
                                Text("Travel Since last fueling")
                                    .fontWeight(.semibold)
                                    .font(.footnote)
                                Spacer()
                                Text("123.22 km")
                                    .font(.system(size: 14, weight: .bold, design: .default))
                                    .foregroundColor(Color.blue)
                            }
                            .padding(10)
                            .background(Color(red: 0.75, green: 0.75, blue: 0.75, opacity: 1))
                            .cornerRadius(10)
                            
                            HStack {
                                Text("Amount of fuel filled")
                                    .fontWeight(.semibold)
                                    .font(.footnote)
                                Spacer()
                                Text("20.12 litre")
                                    .font(.system(size: 14, weight: .bold, design: .default))
                                    .foregroundColor(Color.blue)
                            }
                            .padding(10)
                            .background(Color(red: 0.75, green: 0.75, blue: 0.75, opacity: 1))
                            .cornerRadius(10)
                        }
                        .padding(.vertical, 20)
                                                                    
                        Button {
                            print("hello")
                        }
                    label: {
                        HStack {
                            Spacer()
                            Text("Fueling at the gas station?")
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .frame(width: 300, height: 30, alignment: .center)
                    }
                    .background(Color.blue)
                    .cornerRadius(50)
                       
                    }
                    .padding(5)
                     }
                 Spacer()
                 HStack {
                 Text("FUEL EFFICIENCY HISTORY")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.gray)
                    .frame(height: 40, alignment: .leading)
                    .padding(.leading, 5)
                     Spacer()
                 }
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
            .frame(alignment: .top)
            .navigationTitle(Text("Home"))
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

