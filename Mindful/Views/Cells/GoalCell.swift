//
//  GoalCell.swift
//  Mindful
//
//  Created by William Shelley on 6/30/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct GoalCell: View {
    @State var goal: Goal
    
    var usingGoalToday: Bool {
        let sameGoals = DBM.all(Goal.self).filter { goal in goal.title == self.goal.title }
        let zoneIds = DBM.all(Zone.self).filter( { zone in  zone.date == Date().str() }).map { $0.id }
        for goal in sameGoals {
            if let zoneId = goal.zoneId {
                if zoneIds.contains(zoneId) {
                    return true
                }
            }
        }
        return false
    }
    
    var body: some View {
        NavigationLink(destination: GoalView(goal: self.$goal, isComplete: self.goal.isComplete())){
            HStack {
                Text(goal.title)
                Spacer()
                Text(self.usingGoalToday ? "Active" : "Inactive")
//                Text(goal.dateCompleted.count > 0 ? "Complete" : "In-progress")
//                Spacer()
                VStack(alignment: .center) {
                    Text(goal.description)
                }
            }
        }
    }
}
