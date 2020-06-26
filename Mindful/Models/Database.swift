//
//  Database.swift
//  Mindful
//
//  Created by William Shelley on 6/26/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import Foundation
import GRDB

struct Database {

    static func openDatabase(atPath path: String) throws -> DatabaseQueue {
        dbQueue = try DatabaseQueue(path: path)
        try migrator.migrate(dbQueue!)

        return dbQueue!
    }

    static var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()

        migrator.registerMigration("createDays") { database in
            try database.create(table: Day.databaseTableName) { tableDefinition in
                tableDefinition.column("id", .integer).primaryKey()
                tableDefinition.column("date", .integer).notNull()
            }
        }

        return migrator
    }
}
