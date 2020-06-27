//
//  createGoals.swift
//  Mindful
//
//  Created by William Shelley on 6/26/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import Foundation
import GRDB

let createGoals: (_ migrator: inout DatabaseMigrator) throws -> () = { migrator in
    let tableName = Goal.databaseTableName
    
    if try DBManager.inDatabase(table: tableName) { return }
    
    migrator.registerMigration("create" + tableName.capitalized) { db in
        
        try db.create(table: tableName) { tableDefinition in
            
            tableDefinition.column("id", .integer).primaryKey()
            
            tableDefinition.column("userId", .integer).notNull()
            
            tableDefinition.column("createdDayId", .integer)
                .references(Day.databaseTableName, column: "id", onDelete: .cascade)
                .notNull()
            
            tableDefinition.column("completedDayId", .integer)
                .references(Day.databaseTableName, column: "id", onDelete: .cascade)
            
            tableDefinition.column("deadlineDayId", .integer)
                .references(Day.databaseTableName, column: "id", onDelete: .cascade)
            
            tableDefinition.column("description", .text).notNull()
            
            tableDefinition.column("status", .text).defaults(to: "INCOMPLETE")
            
        }
    }
}
