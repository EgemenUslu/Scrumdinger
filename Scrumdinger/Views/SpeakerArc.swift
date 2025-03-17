//
//  SpeakerArc.swift
//  Scrumdinger
//
//  Created by egemen uslu on 3/16/25.
//

import SwiftUI


struct SpeakerArc: Shape {
    let speakerIndex: Int
    let totalSpeakers: Int
    let secondsElapsedForSpeaker: Int
    let secondsPerSpeaker: Int
    let isEndDynamic: Bool
    let angleGap: Double
    
    init(speakerIndex: Int,
         totalSpeakers: Int,
         totalSeconds: Int = 0,
         secondsElapsedForSpeaker: Int = 0,
         secondsPerSpeaker: Int = 0
    ) {
        self.speakerIndex = speakerIndex
        self.totalSpeakers = totalSpeakers
        self.secondsElapsedForSpeaker = secondsElapsedForSpeaker
        self.secondsPerSpeaker = secondsPerSpeaker
        self.isEndDynamic = secondsPerSpeaker != 0
        self.angleGap = 1.0
    }
    
    private var degreesPerUnit: Double {
        let offsetAmount = 2.0 * angleGap * (Double(totalSpeakers) - 1.0)
        let degreesPerSpeaker = (360 - offsetAmount) / Double(totalSpeakers)
        let degreesPerSecond = (360 - offsetAmount) / Double(totalSpeakers * secondsPerSpeaker)
        
        return isEndDynamic ? degreesPerSecond : degreesPerSpeaker
    }
    
    private var startAngle: Angle {
        let offsetAngle = angleGap * (Double(speakerIndex) * 2.0 + 1)
        let startIndex = isEndDynamic ? Double(speakerIndex * secondsPerSpeaker) : Double(speakerIndex)
        
        return Angle(degrees: startIndex * degreesPerUnit + offsetAngle)
    }
    
    private var endAngle: Angle {
        let currentSecondAngle = Double(secondsElapsedForSpeaker) * degreesPerUnit
        let arcSize = isEndDynamic ? currentSecondAngle : degreesPerUnit
        
        return Angle(degrees: startAngle.degrees + arcSize)
    }
    
    func path(in rect: CGRect) -> Path {
        let diameter = min(rect.size.width, rect.size.height) - 24.0
        let radius = diameter / 2.0
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        return Path { path in
            path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        }
    }
}
