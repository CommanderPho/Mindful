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
    
    @State var presentingCreateBadge: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            
            Text(goal.title)
            Text(goal.description)
            Text("Status: " + goal.status)
            Text("Created At: " + goal.dateCreated)
            Text("Completed At: " + (goal.dateCompleted.isEmpty ? "---" : goal.dateCompleted))
            Text("Due: " + goal.dateDue)
            
            Spacer()
            
            Text("Badges")
            BadgeGridView(badges: Badge.make2D(DBM.hasMany(goal.badges), columns: BADGES_COLLECTION_COLUMNS), spacing: BADGES_CELL_SPACING)
        }
        .aspectRatio(contentMode: .fit)
        .foregroundColor(.blue)
        .navigationBarTitle(Text(goal.title), displayMode: .inline)
            
        .navigationBarItems(trailing: Button("Create Badge") { self.presentingCreateBadge.toggle() }
        .sheet(isPresented: self.$presentingCreateBadge) { NewBadgeView(goal: self.goal) })
    }
}
