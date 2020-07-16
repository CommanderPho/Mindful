//
//  AppView.swift
//  Mindful
//
//  Created by William Shelley on 6/30/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct ContentView: View {    
    var body: some View {
        TabView {
            // Profile
            // Calendar
            // Badges
            // Timer
            
//            ZoneCell(zone: Zone(id: nil, startTime: "", endTime: "", date: "", notes: "", minutesUsed: 0))
//                .tabItem {
//                    Image(systemName: "cloud.sun.bolt")
//                    Text("Awareness")
//            }
//            TestView()
//            ZonesGroupView(date: Date())
//                .tabItem {
//                    Image(systemName: "cloud")
//                    Text("Test")
//            }
            
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
            
            
            AllBadgesView()
            .tabItem {
                Image(systemName: "rosette")
                Text("Badges")
            }
        }
    }
}
