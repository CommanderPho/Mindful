//
//  createBadges.swift
//  Mindful
//
//  Created by William Shelley on 6/26/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import Foundation
import GRDB

//var id: Int64?
//var goalId: Int64?
//
//var title: String
//var description: String
//var imageName: String
//var dateEarned: String

let createBadges: (_ migrator: inout DatabaseMigrator) throws -> () = { migrator in
    let tableName = Badge.databaseTableName
    
    if try DBM.inDatabase(table: tableName) { return }
    
    print("createBadges migration performed")
    
    migrator.registerMigration("create" + tableName.capitalized) { db in
        try db.create(table: tableName) { tableDefinition in
            tableDefinition.column("id", .integer).primaryKey()
            tableDefinition.column("goalId", .integer).references(Goal.databaseTableName).notNull()
            tableDefinition.column("title", .text).notNull()
            tableDefinition.column("description", .text).notNull()
            tableDefinition.column("imageName", .text).defaults(to: "badge")
            tableDefinition.column("dateEarned", .text).notNull()
        }
    }
}
