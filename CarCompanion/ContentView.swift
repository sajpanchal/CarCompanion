//
//  ContentView.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-01-08.
//

import SwiftUI
import CoreData


struct ContentView: View {

    
    var body: some View {
        NavigationView {
             VStack {
                Group {
                    VStack {
                        VStack {
                            HStack {
                                Text("Odometer Reading")
                                    .fontWeight(.bold)
                                    .font(.footnote)
                                    .foregroundColor(Color.black)
                                Spacer()
                                Text("123,111,222,333.22 km")
                                    .foregroundColor(.blue)
                                    .fontWeight(.bold)
                                    .font(.caption)
                            }
                            .padding(10)
                            .background(Color(red: 0.819, green: 0.819, blue: 0.819, opacity: 1))
                            .cornerRadius(10)
                         
                            HStack {
                                Text("Travel Since last fueling")
                                    .fontWeight(.bold)
                                    .font(.footnote)
                                    .foregroundColor(Color.black)
                                Spacer()
                                Text("123.22 km")
                                    .foregroundColor(.blue)
                                    .fontWeight(.bold)
                                    .font(.caption)
                            }
                            .padding(10)
                            .background(Color(red: 0.819, green: 0.819, blue: 0.819, opacity: 1))
                            .cornerRadius(10)
                            
                            HStack {
                                Text("Amount of fuel filled")
                                    .fontWeight(.bold)
                                    .font(.footnote)
                                    .foregroundColor(Color.black)
                                Spacer()
                                Text("20.12 l")
                                    .foregroundColor(.blue)
                                    .fontWeight(.bold)
                                    .font(.caption)
                            }
                            .padding(10)
                            .background(Color(red: 0.819, green: 0.819, blue: 0.819, opacity: 1))
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
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                            Spacer()
                        }
                        .frame( height: 40, alignment: .center)
                    }
                    .background(Color.yellow)
                    .cornerRadius(50)
                       
                    }
                    .padding(5)
                     }
                 Spacer()
                 HStack {
                     Spacer()
                 Text("Fuel Efficiency History")
                     .font(.title)
                     .fontWeight(.black)
                     .foregroundColor(Color.white)
                     Spacer()
                 }
                 .frame(height: 40, alignment: .center)
                 .background(Color.blue)
                 List {
                     VStack {
                         HStack {
                             VStack {
                                 Text("Travel")
                                     .font(.subheadline)
                                     .fontWeight(.bold)
                                 Text("100.23 km")
                                     .font(.subheadline)
                             }
                             Spacer()
                             VStack {
                                 Text("Fuelling")
                                     .font(.subheadline)
                                     .fontWeight(.bold)
                                 Text("100.00 l")
                                     .font(.subheadline)
                             }
                             Spacer()
                             VStack {
                                 Text("Efficiency")
                                     .font(.subheadline)
                                     .fontWeight(.bold)
                                 Text("10.23 km/l")
                                     .font(.subheadline)
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

