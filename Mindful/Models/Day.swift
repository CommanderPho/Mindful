//
//  CalendarDay.swift
//  Mindful
//
//  Created by William Shelley on 6/25/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import GRDB

struct Day: ApplicationRecord {
    var id: Int64? = nil
    var date: String = ""
    
    static let goalsDue = hasMany(Goal.self, using: Goal.deadlineForeignKey)
    static let goalsCompleted = hasMany(Goal.self, using: Goal.completedForeignKey)
    static let goalsCreated = hasMany(Goal.self, using: Goal.createdForeignKey)
    static let badgesEarnedToday = hasMany(Badge.self, using: Badge.dayForeignKey)
    
    var goalsDue: QueryInterfaceRequest<Goal> {
        request(for: Day.goalsDue)
    }
    
    var goalsCompleted: QueryInterfaceRequest<Goal> {
        request(for: Day.goalsCompleted)
    }
    
    var goalsCreated: QueryInterfaceRequest<Goal> {
        request(for: Day.goalsCreated)
    }
    
    var badgesEarnedToday: QueryInterfaceRequest<Badge> {
        request(for: Day.badgesEarnedToday)
    }
}