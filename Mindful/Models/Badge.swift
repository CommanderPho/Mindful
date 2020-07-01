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
    
    var title: String
    var description: String
    var imageName: String
    var dateEarned: String
    
    static let goalForeignKey = ForeignKey(["goalId"])
    static let goal = belongsTo(Goal.self, using: goalForeignKey)
    var goal: QueryInterfaceRequest<Goal> { request(for: Badge.goal) }
}
