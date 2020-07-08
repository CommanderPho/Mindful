//
//  AppView.swift
//  Mindful
//
//  Created by William Shelley on 6/30/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

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
            
            ScrollView(showsIndicators: false){
                BadgeGridView(badges: self.badges, spacing: BADGES_CELL_SPACING)
                    .onReceive([self.badges].publisher.first(), perform: { value in
                        let retrievedBadges = Badge.all2DArray(columns: BADGES_COLLECTION_COLUMNS)
                        if self.badges != retrievedBadges { self.badges = retrievedBadges }
                    })
                    .frame(width: SCREEN_WIDTH, alignment: .topLeading)
            }
            .tabItem {
                Image(systemName: "rosette")
                Text("Badges")
            }
        }
    }
}
