//
//  HistoryView.swift
//  Scrumdinger
//
//  Created by egemen uslu on 3/16/25.
//

import SwiftUI

struct HistoryView: View {
    let history: History
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Divider()
                    .padding(.bottom)
                Text("Attendees")
                    .font(.headline)
                Text(history.attendeeString)
                if let transcript = history.transcript {
                    Text("Transcript")
                        .font(.headline)
                        .padding(.top)
                    Text(transcript)
                }
            }
        }
        .navigationTitle(Text(history.date, style: .date))
        .padding()
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var sampleHistory: History {
        History(
           attendees: DailyScrum.sampleData[0].attendees,
           transcript: "Darla, would you like to start today? Sure, yesterday I reviewed Luis' PR and met with the design team to finalize the UI..."
       )
    }
    
    static var previews: some View {
        HistoryView(history: sampleHistory)
    }
}
