//
//  ZoneView.swift
//  Mindful
//
//  Created by William Shelley on 7/13/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct ZoneView: View {
    var zone: Zone
    var goals: [Goal] { return DBM.hasMany(self.zone.goals) }
    var body: some View {
        VStack {
            Text("Zone View")
            Text(self.zone.date.toDate().formatted())
            Text("start: " + self.zone.startTime.toDateTime().timeStr())
            Text("end: " + self.zone.endTime.toDateTime().timeStr())
            Text("notes: " + self.zone.notes)
            Text("minutesUsed: " + self.zone.minutesUsed.str())
            List {
                ForEach(self.goals) { goal in
                    GoalCell(goal: goal)
                }
            }
        }
    }
}
