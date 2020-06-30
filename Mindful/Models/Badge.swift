//
//  Badge.swift
//  Mindful
//
//  Created by William Shelley on 6/25/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import Foundation
import GRDB

struct Badge: ApplicationRecord {
    var id: Int64?
    var goalId: Int64?
    var dayId: Int64?
    var description: String
    var imageName: String
    
    static let goal = belongsTo(Goal.self)
    var goal: QueryInterfaceRequest<Goal> {
        request(for: Badge.goal)
    }
    
    static let dayEarned = belongsTo(Day.self)
    var dayEarned: QueryInterfaceRequest<Day> {
        request(for: Badge.dayEarned)
    }
}
