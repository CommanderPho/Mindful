//
//  DBManager.swift
//  Mindful
//
//  Created by William Shelley on 6/26/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import Foundation
import GRDB

let dbName = "db.sqlite"
var dbQueue: DatabaseQueue?
var migrations: [(inout DatabaseMigrator) throws ->Void]? = nil

class DBManager {
    enum DBError: Error {
        case migrationsError(String), queueError(String)
    }
    
    // creates and returns a DatabaseQueue connection
    static func connectDB(atPath path: String, withMigrations loadedMigrations: [(inout DatabaseMigrator) throws ->Void]? ) throws -> DatabaseQueue {
        dbQueue = try DatabaseQueue(path: path)
        try performMigrations(loadedMigrations)
        return dbQueue!
    }
    
    // erases entire database designated by dbQueue
    static func eraseDB() throws {
        guard let dbQueue = dbQueue else { throw DBError.queueError("Invalid Database Connection") }
        try dbQueue.erase()
    }
    
    // returns true if table with given name is in database
    static func inDatabase(table: String) throws -> Bool {
        guard let dbQueue = dbQueue else { throw DBError.queueError("Invalid Database Connection") }
        var tableExists: Bool = false
        try dbQueue.read({ db in
            tableExists = try db.tableExists(table)
        })
        return tableExists
    }
 
    // migrates an array of migrations ( Mindful/Models/Migrations )
    private static func performMigrations(_ migrations: [(inout DatabaseMigrator) throws ->Void]?) throws {
        guard let dbQueue = dbQueue else { throw DBError.queueError("Invalid Database Connection")}
        guard let migrations = migrations else { throw DBError.migrationsError("Invalid Migrations")}
        
//        try! DBManager.eraseDB()
        
        var migrator = DatabaseMigrator()
        for migration in migrations {
            try migration(&migrator)
        }
        try migrator.migrate(dbQueue)
    }
}
