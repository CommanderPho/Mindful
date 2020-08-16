//
//  AppView.swift
//  Mindful
//
//  Created by William Shelley on 6/30/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var showYesterdayGoalsModal: Bool = true
    @State var showToday: Bool = true
    var body: some View {
        TabView {
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Progress")
            }
            
            CalendarView(focusDate: Date(), spacing: CALENDAR_CELL_SPACING)
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
            }
//            .sheet(isPresented: self.$showToday, content: { DayView(date: Date()) })
            
        }
//        .sheet(isPresented: self.$showYesterdayGoalsModal, content: { GoalsListFromGoalsView(goals: Date().offsetBy(-1, withUnit: .day).goals()) })
    
    }
}

func createUncreatedBadges() {
    let goals = DBM.all(Goal.self)
    let filtered = goals.filter { goal in goal.dateCompleted.count > 0 }
    for goal in filtered {
        if DBM.hasMany(goal.badges).count <= 0 {
            let newBadge = Badge(id: nil, goalId: goal.id, title: "Completed Goal", description: "Completed a goal on " + goal.dateCompleted + "!", imageName: "2day", dateEarned: goal.dateCompleted)
            _ = DBM.insert(newBadge)
        }
    }
}
