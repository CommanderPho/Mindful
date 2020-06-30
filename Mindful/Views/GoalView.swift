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
        VStack(alignment: .center) {
            Text(goal.description)
            Text(goal.status)
        }
        .aspectRatio(contentMode: .fit)
        .foregroundColor(.blue)
        .navigationBarTitle(Text(goal.description), displayMode: .inline)
    }
}
