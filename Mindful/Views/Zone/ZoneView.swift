//
//  ZoneView.swift
//  Mindful
//
//  Created by William Shelley on 7/13/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct ZoneView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var presentingNewGoal: Bool = false
    var zone: Zone
    
    @State var goals: [Goal] = []
    @State var allGoals: [Goal] = []
    @State var selectedGoals: [Goal] = []
    var fetchedGoals: [Goal] {
        let allGoals: [Goal] = DBM.all(Goal.self)
        var uniqueGoals: [Goal] = []
        var uniqueTitles: Set<String> = []
        for goal in allGoals {
            if !uniqueTitles.contains(goal.title) {
                uniqueTitles.insert(goal.title)
                uniqueGoals.append(goal)
            }
        }
        
        return uniqueGoals
    }
    @State var displayAddGoals: Bool = false
    var body: some View {
        VStack {
            Text("Goals")
                .font(.largeTitle)
//            Text(self.zone.date.toDate().formatted())
//            Text("start: " + self.zone.startTime.toDateTime().timeStr())
//            Text("end: " + self.zone.endTime.toDateTime().timeStr())
//            Text("notes: " + self.zone.notes)
//            Text("minutesUsed: " + self.zone.minutesUsed.str())
            List {
                ForEach(self.goals) { goal in
                    GoalCell(goal: goal)
                }.onDelete(perform: { indexSet in
                    if DBM.delete(self.goals[indexSet.first!]) {
                        self.goals = DBM.hasMany(self.zone.goals)
                    }
                })
            }
//            GoalsListView(date: self.zone.date.toDate())
        }
        .navigationBarItems(trailing: Button(action: {
            self.displayAddGoals.toggle()
        }) {
        Text("Add a goal")
    })
        .onAppear {
            self.goals = DBM.hasMany(self.zone.goals)
            self.allGoals = self.fetchedGoals
        }
        .sheet(isPresented: self.$displayAddGoals) {
            VStack {
                HStack {
                    Button("Create new Goal", action: {
                        self.presentingNewGoal.toggle()
                    })
                    Spacer()
                    .sheet(isPresented: self.$presentingNewGoal, content: {
                        NewGoalView(dateDue: Date())
                    })

                    
                Button("Add goals", action: {
                    var i = 0
                    while i < self.selectedGoals.count {
                        self.selectedGoals[i].zoneId = self.zone.id
                        self.selectedGoals[i].id = nil
                        self.selectedGoals[i].dateDue = Date().str()
                        
                        _ = DBM.insert(self.selectedGoals[i])
                        i+=1
                    }
                    self.goals = DBM.hasMany(self.zone.goals)

                    self.displayAddGoals = false
                })
                }
                MultipleSelectionList(items: self.$allGoals, selections: self.$selectedGoals)
            }
        }
        .onReceive([self.$presentingNewGoal].publisher.first(), perform: { value in
            self.allGoals = self.fetchedGoals
            
        })
//        .onReceive([self.$displayAddGoals].publisher.first(), perform: { value in
//            print(value)
//            print(self.displayAddGoals)
//        })
    }
}
