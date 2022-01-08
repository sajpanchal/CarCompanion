//
//  ContentView.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-01-08.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    

    var body: some View {
        Text(items.first!.timestamp!, style: .date)
            .onAppear(perform: {
                let item = Item(context: viewContext)
                item.timestamp = Date(timeIntervalSince1970: 0)
                do {
                    try viewContext.save()
                }
                catch {
                    fatalError("Something went wrong!")
                }
            })
    }
        

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
