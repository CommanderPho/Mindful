//
//  createBadges.swift
//  Mindful
//
//  Created by William Shelley on 6/26/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import Foundation
import GRDB

let createBadges: (_ migrator: inout DatabaseMigrator) throws -> () = { migrator in
    let tableName = Badge.databaseTableName
    
    if try DBM.inDatabase(table: tableName) { return }
    
    print("createBadges migration performed")
    
    migrator.registerMigration("create" + tableName.capitalized) { db in
        try db.create(table: tableName) { tableDefinition in
            tableDefinition.column("id", .integer).primaryKey()
            tableDefinition.column("goalId", .integer).references(Goal.databaseTableName, onDelete: .cascade).notNull()
            tableDefinition.column("title", .text).notNull().check { length($0) > 0 }
            tableDefinition.column("description", .text).notNull().check { length($0) > 0 }
            tableDefinition.column("imageName", .text).notNull().defaults(to: "badge")
            tableDefinition.column("dateEarned", .text)
        }
    }
}
