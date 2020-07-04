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
    @State var badges: [[Badge]] = Badge.all2DArray(columns: BADGES_COLLECTION_COLUMNS)
    let chosenDay: Date = Date()
    
    var body: some View {
        TabView {
            
            // Profile
            // Calendar
            // Badges
            // Timer
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
            }
            
            CalendarView(focusDate: Date(), spacing: CALENDAR_CELL_SPACING)
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
            }
            
            BadgeGridView(badges: self.badges, spacing: BADGES_CELL_SPACING)
                .tabItem {
                    Image(systemName: "rosette")
                    Text("Badges")
            }
            .onAppear() { self.badges = Badge.all2DArray(columns: BADGES_COLLECTION_COLUMNS) }

        }
    }
}
