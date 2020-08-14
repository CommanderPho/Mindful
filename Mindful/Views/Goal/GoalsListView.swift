//
//  GoalsListView.swift
//  Mindful
//
//  Created by William Shelley on 7/13/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct GoalsListFromGoalsView: View {
    
    @State var goals: [Goal]
    var body: some View {
        VStack {
            Spacer()
            Text("Goals")
                .font(.largeTitle)
            
            List{
                ForEach(self.goals) { goal in
                    GoalCell(goal: goal)
                }
            .navigationBarTitle(Text("Goals"), displayMode: .inline)
        }
    }
}
}

struct GoalsListView: View {
    @State private var showingNewGoalModal: Bool = false
    
    var date: Date
    @State private var goals: [Goal] = []
    var body: some View {
        VStack {
            Spacer()
            Text("Goals")
                .font(.largeTitle)
            
            List{
                ForEach(self.goals) { goal in
                    GoalCell(goal: goal)
                }.onDelete(perform: { indexSet in
                    if DBM.delete(self.goals[indexSet.first!]) {
                        self.goals = self.date.goals()
                    }
                })
            }
            .navigationBarTitle(Text(self.date.formatted()), displayMode: .inline)
            .navigationBarItems(trailing:
                Image(systemName: "plus")
                    .onTapGesture { self.showingNewGoalModal.toggle() }
                    .foregroundColor(.accentColor)
                    .sheet(isPresented: self.$showingNewGoalModal, content: { NewGoalView(dateDue: self.date)}))
                .onReceive([self.goals].publisher.first(), perform: { value in
                    if self.goals != self.date.goals() {
                        self.goals = self.date.goals()
                    }
                })
        }
    }
}
