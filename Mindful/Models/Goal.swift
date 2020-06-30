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
    var userId: Int64?
    var description: String
    var status: String
    
    var createdDayId: Int64?
    var completedDayId: Int64?
    var deadlineDayId: Int64?
    
    static let createdForeignKey = ForeignKey(["createdDayId"])
    static let completedForeignKey = ForeignKey(["completedDayId"])
    static let deadlineForeignKey = ForeignKey(["deadlineDayId"])
    
    static let dayCreated = belongsTo(Day.self, using: createdForeignKey)
    static let dayCompleted = belongsTo(Day.self, using: completedForeignKey)
    static let dueDate = belongsTo(Day.self, using: deadlineForeignKey)
    
    var dayCreated: QueryInterfaceRequest<Day> {
        request(for: Goal.dayCreated)
    }
    
    var dayCompleted: QueryInterfaceRequest<Day> {
        request(for: Goal.dayCompleted)
    }
    
    var dueDate: QueryInterfaceRequest<Day> {
        request(for: Goal.dueDate)
    }
}
