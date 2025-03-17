//
//  MeetingTimerView.swift
//  Scrumdinger
//
//  Created by egemen uslu on 3/16/25.
//

import SwiftUI

struct MeetingTimerView: View {
    @ObservedObject var scrumTimer: ScrumTimer
    let theme: Theme
    let isRecording: Bool
    
    private var currentSpeaker: String {
        scrumTimer.speakers.first(where: { !$0.isCompleted })?.name ?? "Someone"
    }
    
    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24)
            .overlay {
                VStack {
                    Text(currentSpeaker)
                        .font(.title)
                    Text("is speaking")
                    Image(systemName: isRecording ? "mic" : "mic.slash")
                        .font(.title)
                        .padding(.top)
                        .accessibilityLabel(isRecording ? "With transcription" : "Without transcription")
                }
                .accessibilityElement(children: .combine)
                .foregroundColor(theme.accentColor)
            }
            .overlay {
                ForEach(scrumTimer.speakers) { speaker in
                    if speaker.isCompleted, let index = scrumTimer.speakers.firstIndex(
                        where: { $0.id == speaker.id }
                    ) {
                        SpeakerArc(
                            speakerIndex: index,
                            totalSpeakers: scrumTimer.speakers.count
                        )
                        .rotation(Angle(degrees: -90))
                        .stroke(theme.mainColor, lineWidth: 12)
                    }
                }
            }
            .overlay {
                SpeakerArc(
                    speakerIndex: scrumTimer.speakerIndex,
                    totalSpeakers: scrumTimer.speakers.count,
                    secondsElapsedForSpeaker: scrumTimer.secondsElapsedForSpeaker,
                    secondsPerSpeaker: scrumTimer.secondsPerSpeaker
                )
                .rotation(Angle(degrees: -90))
                .stroke(theme.mainColor.opacity(0.9), lineWidth: 10)
            }
            .padding(.horizontal)
    }
}

struct MeetingTimerView_Previews: PreviewProvider {
    static var scrumTimerExample: ScrumTimer {
        ScrumTimer(
            lengthInMinutes: 1,
            attendees: [
                DailyScrum.Attendee(name: "Egemen"),
                DailyScrum.Attendee(name: "Ariel")
            ])
    }
    
    static var previews: some View {
        MeetingTimerView(
            scrumTimer: scrumTimerExample,
            theme: .yellow,
            isRecording: false
        )
    }
}
