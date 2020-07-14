//
//  ZoneCell.swift
//  Mindful
//
//  Created by William Shelley on 7/10/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

// consider using outside library
// https://iosexample.com/ios-calendar-week-day-view-in-swift/

struct ZoneCell: View {
    var zone: Zone
    
    private let hourHeight: CGFloat = 50
    
    private var color: Color {
        let colors: [Color] = [.red, .green, .blue, .purple, .pink, .orange, .yellow]
        let color: Color = colors[Int.random(in: 0...100) % colors.count]
        return color
    }
    
    private var mins: Int {
        return Date.minsBetween(start: self.zone.startTime, end: self.zone.endTime)
    }
    
    private var heightMod: CGFloat {
        return CGFloat(mins) / 60
    }
    
    private var yPos: CGFloat {
        let numMins: Int = Date.minsBetween(start: "00:00", end: self.zone.startTime)
        let hours: CGFloat = CGFloat(numMins) / 60
        return hourHeight + hours * hourHeight
    }
    
    var body: some View {
        GeometryReader { g in
            Rectangle()
        }
        .frame(width: 200, height: self.hourHeight * self.heightMod, alignment: .center)
        .position(x: SCREEN_WIDTH / 2, y: self.yPos)
        .foregroundColor(self.color)
    .zIndex(1)
    }
}
