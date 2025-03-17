//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by egemen uslu on 3/6/25.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MeetingView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
