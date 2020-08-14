//
//  AwarenessZone.swift
//  Mindful
//
//  Created by William Shelley on 7/9/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import GRDB

struct Zone: ApplicationRecord {
    var id: Int64?
    var uuid: String
    
    var startTime: String
    var endTime: String
    var date: String
    var notes: String
    var minutesUsed: Int
    
    static let goals = hasMany(Goal.self, using: Goal.zoneForeignKey)
    var goals: QueryInterfaceRequest<Goal> { request(for: Zone.goals) }
}
