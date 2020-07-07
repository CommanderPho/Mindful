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
    
    @State private var presentingCreateBadge: Bool = false
    @State private var isComplete: Bool = false
    @State private var errorMessage: String = ""

    
    var body: some View {
        return ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: 10) {
                Text(self.errorMessage)
                    .foregroundColor(.red)
                
                Spacer()
                
                VStack(alignment: .center, spacing: 10) {
                    Text(goal.description)
                    HStack(alignment: .center, spacing: 10) {
                        Toggle("Completed?", isOn: self.$isComplete)
                        
                    }
                    Text("Created At: " + goal.dateCreated)
                    Text("Completed At: " + (goal.dateCompleted.isEmpty ? "---" : goal.dateCompleted))
                    Text("Due: " + goal.dateDue)
                }
                .foregroundColor(.secondary)
                
                Spacer()
                
                HStack(alignment: .center, spacing: 10) {
                    
                    Text("Badges")
                        .foregroundColor(.secondary)
                    
                    Image(systemName: "plus")
                        .onTapGesture { self.presentingCreateBadge.toggle() }
                        .foregroundColor(.accentColor)
                        .sheet(isPresented: self.$presentingCreateBadge, content: { NewBadgeView(goal: self.goal)})
                    
                }
                
                BadgeGridView(badges: Badge.make2D(DBM.hasMany(goal.badges), columns: BADGES_COLLECTION_COLUMNS),
                              spacing: BADGES_CELL_SPACING)
                
                Spacer()
                
            }
        }
        .aspectRatio(contentMode: .fit)
        .foregroundColor(.blue)
        .navigationBarTitle(Text(goal.title), displayMode: .inline)
    }
    
}
