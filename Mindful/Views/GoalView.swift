//
//  GoalView.swift
//  Mindful
//
//  Created by William Shelley on 6/30/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct GoalView: View {
    let goal: Goal
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(goal.title)
            Text(goal.description)
            Text("Status: " + goal.status)
            Text("Created At: " + goal.dateCreated)
            Text("Completed At: " + (goal.dateCompleted.isEmpty ? "---" : goal.dateCompleted))
            Text("Due: " + goal.dateDue)
            Text("Badges: " + titles(DBM.hasMany(goal.badges)).joined(separator: ", "))
        }
        .aspectRatio(contentMode: .fit)
        .foregroundColor(.blue)
        .navigationBarTitle(Text(goal.title), displayMode: .inline)
    }
}

private func titles(_ badges: [Badge]) -> [String] {
    var list: [String] = []
    for badge in badges {
        list.append(badge.title)
    }
    return list
}
