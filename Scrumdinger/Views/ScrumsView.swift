//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by egemen uslu on 3/9/25.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    @Environment(\.scenePhase) private var scenePhase
    @State var isPresentingNewScrumView: Bool = false
    let saveAction: () -> Void
    
    var body: some View {
        NavigationStack {
            List{
                ForEach($scrums) { $scrum in
                    NavigationLink (destination: DetailView(scrum: $scrum)){
                        CardView(scrum: scrum)
                    }.listRowBackground(scrum.theme.mainColor)
                }
                .onDelete(perform: deleteScrum)
            }
            .navigationTitle("Daily Scrums")
            .toolbar {
                Button(action: {
                    isPresentingNewScrumView = true
                }) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel(Text("New Scrum"))
            }
        }
        .sheet(isPresented: $isPresentingNewScrumView){
            NewScrumSheet(isPresentingNewScrumView: $isPresentingNewScrumView, scrums: $scrums)
        }
        .onChange(of: scenePhase) {
            if scenePhase == .inactive {
                saveAction()
            }
        }

    }
    
    // Function to handle deletion
    private func deleteScrum(at offsets: IndexSet) {
        scrums.remove(atOffsets: offsets)
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        ScrumsView(
            scrums: .constant(DailyScrum.sampleData),
            saveAction: {}
        )
    }
}
