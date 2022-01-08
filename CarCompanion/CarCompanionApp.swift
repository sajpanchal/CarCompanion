//
//  CarCompanionApp.swift
//  CarCompanion
//
//  Created by saj panchal on 2022-01-08.
//

import SwiftUI

@main
struct CarCompanionApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
