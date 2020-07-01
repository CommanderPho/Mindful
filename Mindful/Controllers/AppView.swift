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
    
    var days: [Day] = []
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
            
//            TableView(data: DBM.hasMany(days[0].badgesEarnedToday))
            GoalsTable(goals: DBM.all(Goal.self))
                .tabItem {
                    Image(systemName: "rosette")
                    Text("Badges")
            }
            
            DaysCollection(numCols: daysNumCols, spacing: daysSpacing)
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
            }
            
        }
        .foregroundColor(.blue)
    }
}
