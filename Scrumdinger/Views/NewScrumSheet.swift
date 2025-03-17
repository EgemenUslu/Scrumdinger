//
//  NewScrumSheet.swift
//  Scrumdinger
//
//  Created by egemen uslu on 3/12/25.
//

import SwiftUI

struct NewScrumSheet: View {
    @State private var newScrum: DailyScrum = DailyScrum.emptyScrum
    @Binding var isPresentingNewScrumView: Bool
    @Binding var scrums: [DailyScrum]
    
    var body: some View {
        NavigationStack {
            DetailEditView(scrum: $newScrum)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresentingNewScrumView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            scrums.append(newScrum)
                            isPresentingNewScrumView = false
                        }
                    }

                }
        }
    }
}

struct NewScrumSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewScrumSheet(
            isPresentingNewScrumView: .constant(true),
            scrums: .constant(DailyScrum.sampleData)
        )
    }
}
