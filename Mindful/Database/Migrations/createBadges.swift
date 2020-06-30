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
            tableDefinition.column("goalId", .integer).references(Goal.databaseTableName)
            tableDefinition.column("dayId", .integer)
            tableDefinition.column("description", .text).notNull()
            tableDefinition.column("imageName", .text).defaults(to: "badge")
        }
    }
}
