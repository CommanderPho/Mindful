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
    
    static func all2DArray(columns: Int) -> [[Badge]] {
        return Badge.make2D(DBM.all(Badge.self), columns: columns)
    }
    
    static func make2D(_ badges: [Badge], columns: Int) -> [[Badge]] {
        var rows:[[Badge]] = [[Badge]()]
        
        for badge in badges {
            var lastRowIdx: Int = rows.count - 1
            if rows[lastRowIdx].count >= columns {
                rows.append([])
                lastRowIdx = rows.count - 1
            }
            rows[lastRowIdx].append(badge)
        }
        return rows
    }
    
    func isEarned() -> Bool {
        return !self.dateEarned.isEmpty
    }
}
