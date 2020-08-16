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
    @State var zone: Zone
//    let hourHeight: CGFloat
    
//    private var color: Color {
//        let colors: [Color] = [.red, .green, .purple, .pink, .orange, .yellow]
//        let color: Color = colors[Int.random(in: 0...100) % colors.count]
//        return color
//    }
//    
//    private var height: CGFloat {
//        let mins: Int =  abs(Date.minsBetween(start: self.zone.startTime, end: self.zone.endTime))
//        let h: CGFloat = (CGFloat(mins) / 60) * hourHeight
//        
//        return h
//    }
//    
//    private var yPos: CGFloat {
//        let mins: Int = Date.minsBetween(start: "00:00", end: self.zone.startTime)
//        let y: CGFloat = (CGFloat(mins) / 60) * hourHeight
//        return y - self.height / 2 //+ self.hourHeight / 2
//    }
    
    var goals: [Goal] { return DBM.hasMany(self.zone.goals) }
    var goalsCompleted: [Bool] { return goals.map { $0.dateCompleted.count > 0 }.filter { included in included == true } }
    @State var numGoalsCompleted: Int = 0
    @State var numGoals: Int = 0
    var body: some View {
        NavigationLink(destination: ZoneView(zone: self.zone)){
            HStack {
                Text(zone.startTime + "-" + zone.endTime)
                Spacer()
                Text(self.numGoalsCompleted.str() + "/" + self.numGoals.str())
            }
        }.onAppear {
            self.numGoalsCompleted = self.goalsCompleted.count
            self.numGoals = self.goals.count
        }
    }
}
