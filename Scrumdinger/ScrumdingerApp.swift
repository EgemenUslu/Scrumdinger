//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by egemen uslu on 3/6/25.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @StateObject private var store = ScrumStore()
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            ScrumsView(
                scrums: $store.scrums
            ) {
                Task {
                    do {
                        try await store.save(scrums: store.scrums)
                    } catch {
                        errorWrapper = ErrorWrapper(
                            error: error,
                            guidance: "Data cannot be saved. Please try again later."
                        )
                    }
                }
            }
            .task {
                do {
                    try await store.load()
                } catch {
                    errorWrapper = ErrorWrapper(
                        error: error,
                        guidance: "Data cannot be loaded. Please try again."
                    )
                }
            }
            .sheet(item: $errorWrapper) {
                store.scrums = DailyScrum.sampleData
            } content: { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
        }
    }
}
