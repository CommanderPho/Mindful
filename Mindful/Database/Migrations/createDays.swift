//
//  createDays.swift
//  Mindful
//
//  Created by William Shelley on 6/26/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import Foundation
import GRDB

let createDays: (_ migrator: inout DatabaseMigrator) throws -> () = { migrator in
    let tableName = Day.databaseTableName
    
    if try DBM.inDatabase(table: tableName) { return }
    
    print("createDays migration performed")
    
    migrator.registerMigration("create" + tableName.capitalized) { db in
        try db.create(table: tableName) { tableDefinition in
            tableDefinition.column("id", .integer).primaryKey()
            tableDefinition.column("date", .integer).notNull()
        }
    }
}
