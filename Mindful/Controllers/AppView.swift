//
//  AppView.swift
//  Mindful
//
//  Created by William Shelley on 6/30/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

private let daysNumCols: Int = 7
private let daysSpacing: CGFloat = 5

struct ContentView: View {
    
    var goals: [Goal] = DBM.all(Goal.self)
    var badges: [Badge] = DBM.all(Badge.self)
    let chosenDay: Date = Date()
    
    var body: some View {
        TabView {
            
            // Profile
            // Calendar
            // Badges
            // Timer

            CalendarView(focusDate: Date(), spacing: CALENDAR_CELL_SPACING)
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
            }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
            }
            
//            GoalsView(date: chosenDay)
//                .tabItem {
//                    Image(systemName: "rosette")
//                    Text("Badges")
//            }
//
            
        }
        .foregroundColor(.blue)
    }
}
