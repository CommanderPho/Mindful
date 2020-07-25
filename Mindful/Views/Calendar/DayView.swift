//
//  GoalsTable.swift
//  Mindful
//
//  Created by William Shelley on 6/30/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct DayView: View {
    @State private var showingNewGoalModal: Bool = false
    
    var date: Date
    @State private var goals: [Goal] = []
    
    var body: some View {
//        GoalsListView(date: self.date)
//        ZonesGroupView(date: self.date)
        ZonesListView(date: self.date)
    }
}
