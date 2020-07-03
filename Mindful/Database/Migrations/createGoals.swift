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
    
    if try DBM.inDatabase(table: tableName) { return }
    
    print("createGoals migration performed")
    
    migrator.registerMigration("create" + tableName.capitalized) { db in
        
        try db.create(table: tableName) { tableDefinition in
            tableDefinition.column("id", .integer).primaryKey()
            tableDefinition.column("title", .text).notNull().check { length($0) > 0 }
            tableDefinition.column("description", .text).notNull().check { length($0) > 0 }
            tableDefinition.column("status", .text).defaults(to: "IN-PROGRESS").notNull().check { length($0) > 0 }
            tableDefinition.column("dateCreated", .text).notNull().check { length($0) == dateLength }
            tableDefinition.column("dateCompleted", .text)
            tableDefinition.column("dateDue", .text).notNull().check { length($0) == dateLength }
        }
    }
}
