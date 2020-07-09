//
//  AppView.swift
//  Mindful
//
//  Created by William Shelley on 6/30/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct ContentView: View {
//    @State private var badges: [[Badge]] = []
    
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
            
            AllBadgesView()
            .tabItem {
                Image(systemName: "rosette")
                Text("Badges")
            }
        }
    }
}
