//
//  createAwarenessZones.swift
//  Mindful
//
//  Created by William Shelley on 7/9/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import Foundation
import GRDB

let createZones: (_ migrator: inout DatabaseMigrator) throws -> () = { migrator in
    let tableName = Zone.databaseTableName
    
    if try DBM.inDatabase(table: tableName) { return }
    
    print("createBadges migration performed")
    
    migrator.registerMigration("create" + tableName.capitalized) { db in
        try db.create(table: tableName) { tableDefinition in
            tableDefinition.column("id", .integer).primaryKey()
            
            tableDefinition.column("startTime", .text).notNull().check { length($0) > 0 }
            tableDefinition.column("endTime", .text).notNull().check { length($0) > 0 }
            tableDefinition.column("date", .text).notNull().check { length($0) == DATE_FORMAT_LENGTH }
            tableDefinition.column("notes", .text)
            tableDefinition.column("minutesUsed", .integer).notNull().defaults(to: 0)
        }
    }
}

