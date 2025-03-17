//
//  EditScrumView.swift
//  Scrumdinger
//
//  Created by egemen uslu on 3/12/25.
//

import SwiftUI

struct EditScrumView: View {
    @Binding var scrum: DailyScrum
    @Binding var editingScrum: DailyScrum
    @Binding var isPresentingEditView: Bool
    
    
    var body: some View {
        NavigationStack {
            DetailEditView(scrum: $editingScrum)
                .navigationTitle(scrum.title)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            isPresentingEditView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            scrum = editingScrum
                            isPresentingEditView = false
                        }
                    }
                }
        }
    }
}

struct EditScrumView_Previews: PreviewProvider {
    static var previews: some View {
        EditScrumView(
            scrum: .constant(DailyScrum.emptyScrum),
            editingScrum: .constant(DailyScrum.emptyScrum),
            isPresentingEditView: .constant(true)
        )
    }
}
