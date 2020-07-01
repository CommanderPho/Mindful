//
//  Goal.swift
//  Mindful
//
//  Created by William Shelley on 6/25/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import GRDB

struct Goal: ApplicationRecord {
    
    var id: Int64?
    
    var title: String
    var description: String
    var status: String
    var dateCreated: String
    var dateCompleted: String
    var dateDue: String
    
    static let badges = hasMany(Badge.self, using: Badge.goalForeignKey)
    var badges: QueryInterfaceRequest<Badge> { request(for: Goal.badges) }
}
