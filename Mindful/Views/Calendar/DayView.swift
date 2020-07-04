//
//  GoalsTable.swift
//  Mindful
//
//  Created by William Shelley on 6/30/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

// lists all the goals defined by Date.goals()
struct DayView: View {
    @State private var showingNewGoalModal: Bool = false
    
    var date: Date
    private var goals: [Goal] {
        return date.goals()
    }
    
    var body: some View {
        List(self.goals) { goal in
            GoalCell(goal: goal)
        }
        .navigationBarTitle(Text(self.date.formatted()), displayMode: .inline)
        .navigationBarItems(trailing:
            Text("Add a Goal")
            .onTapGesture { self.showingNewGoalModal.toggle() }
            .foregroundColor(.accentColor)
            .sheet(isPresented: self.$showingNewGoalModal, content: { NewGoalView(dateDue: self.date)}))
        
    }
}
