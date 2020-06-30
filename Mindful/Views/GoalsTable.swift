//
//  GoalsTable.swift
//  Mindful
//
//  Created by William Shelley on 6/30/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct GoalsTable: View {
    @State var goals: [Goal]
    
    var body: some View {
        NavigationView {
            List(goals) { goal in
                NavigationLink(destination: GoalView(goal: goal)){
                    GoalCell(goal: goal)
                }
            }
        }
    }
}

struct GoalsTable_Previews: PreviewProvider {
    static var previews: some View {
        GoalsTable(goals: DBM.all(Goal.self))
    }
}
