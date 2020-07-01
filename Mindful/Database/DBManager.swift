//
//  DBManager.swift
//  Mindful
//
//  Created by William Shelley on 6/26/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import GRDB

let dbName = "db.sqlite"
var dbQueue: DatabaseQueue?
var migrations: [(inout DatabaseMigrator) throws ->Void]? = nil

typealias DBM = DBManager

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
    
    // returns an array of objects retrieved from DB via a hasMany association
    static func hasMany<T: ApplicationRecord>(_ hasMany: QueryInterfaceRequest<T>) -> [T]{
        var records: [T] = []
        try? dbQueue?.read({ db in records = try hasMany.fetchAll(db) })
        return records
    }
    
    // returns an array of all objects of a given AR type from the DB
    static func all<T: ApplicationRecord>(_ type: T.Type) -> [T]{
        var records: [T] = []
        try? dbQueue?.read({ db in records = try T.fetchAll(db) })
        return records
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
        
//        try! DBM.seed(15)
    }
    
    // seed database
    private static func seed(_ numSeeds: Int) throws {
        guard let dbQueue = dbQueue else { throw DBError.queueError("Invalid Database Connection") }
        let idx = DBM.all(Goal.self).count
        
        try dbQueue.write({ db in
            
            
            for i in idx..<(idx+numSeeds) {
                let dayOffset: Int = 5

                let goal = Goal(id: nil,
                      title: "Title " + String(i),
                      description: "Description " + String(i),
                      status: "INCOMPLETE",
                      dateCreated: Date().toStr(),
                      dateCompleted: "",
                      dateDue: Date().offsetBy(dayOffset, withUnit: .day).toStr())

                try goal.insert(db)
                let goalId = try Goal.fetchAll(db).last!.id
                
                let badge = Badge(id: nil,
                      goalId: goalId,
                      title: "Title " + String(i),
                      description: "Description " + String(i),
                      imageName: "badge",
                      dateEarned: Date().offsetBy(dayOffset, withUnit: .day).toStr())
                
                try badge.insert(db)
            }
        })
    }
}
