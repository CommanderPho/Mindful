//
//  Badge.swift
//  Mindful
//
//  Created by William Shelley on 6/25/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import GRDB

struct Badge: ApplicationRecord {
    var id: Int64?
    var goalId: Int64?
    var dayId: Int64?
    var description: String
    var imageName: String
    
    static let dayForeignKey = ForeignKey(["dayId"])
    
    static let goal = belongsTo(Goal.self)
    static let dayEarned = belongsTo(Day.self)
    
    var goal: QueryInterfaceRequest<Goal> {
        request(for: Badge.goal)
    }
    
    var dayEarned: QueryInterfaceRequest<Day> {
        request(for: Badge.dayEarned)
    }
}
