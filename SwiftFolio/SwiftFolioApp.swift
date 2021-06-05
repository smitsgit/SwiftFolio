//
//  SwiftFolioApp.swift
//  SwiftFolio
//
//  Created by Smital on 05/06/21.
//
//

import SwiftUI

@main
struct SwiftFolioApp: App {
    let persistenceController = PersistenceController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
