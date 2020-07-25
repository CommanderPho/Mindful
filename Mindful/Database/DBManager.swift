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
    
    // inserts model into DB, returns true on successful store
    static func insert<T: ApplicationRecord>(_ model: T) -> Bool {
        var success: Bool = false
        try? dbQueue?.write({ db in
            db.afterNextTransactionCommit { db in
                success = true
            }
            try model.insert(db)
        })
        
        return success
    }
    
    // updates row in DB
    static func update<T: ApplicationRecord>(_ model: T) -> Bool {
        var success: Bool = false
        try? dbQueue?.write({ db in
            db.afterNextTransactionCommit { db in
                success = true
            }
            try model.update(db)
        })
        
        return success
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
    
    // finds the first object in DB that matches sql query string
    static func findOne<T: ApplicationRecord>(_ model: T.Type, where sql: String) -> T? {
        var record: T?
        try? dbQueue?.read({ db in
            record = try T.filter(sql: sql).fetchOne(db)
        })
        return record
    }
    
    // find the first object in DB that matches the given primary key (id)
    static func findById<T: ApplicationRecord>(_ model: T.Type, id: Int64?) -> T? {
        var record: T?
        try? dbQueue?.read({ db in
            record = try T.filter(key: ["id": id]).fetchOne(db)
        })
        return record
    }
    
    // delete item from DB
    static func delete<T: ApplicationRecord>(_ model: T) -> Bool {
        var success: Bool = false
        try? dbQueue?.write({ db in
            success = try model.delete(db)
        })
        return success
    }
 
    // migrates an array of migrations ( Mindful/Models/Migrations )
    private static func performMigrations(_ migrations: [(inout DatabaseMigrator) throws ->Void]?) throws {
        guard let dbQueue = dbQueue else { throw DBError.queueError("Invalid Database Connection")}
        guard let migrations = migrations else { throw DBError.migrationsError("Invalid Migrations")}
        
        if SHOULD_ERASE_DB { try! DBManager.eraseDB() }

        
        var migrator = DatabaseMigrator()
        for migration in migrations {
            try migration(&migrator)
        }
        try migrator.migrate(dbQueue)
        
        
        if SHOULD_SEED_DB { try! DBM.seed(Date().numDays(in: .month), nTimes: 5) }
        
    }
    
    // seed database
    private static func seed(_ numSeeds: Int, nTimes num: Int = 1) throws {
        guard let dbQueue = dbQueue else { throw DBError.queueError("Invalid Database Connection") }
        
        for _ in 0..<num{
        let idx = DBM.all(Goal.self).count
            try dbQueue.write({ db in
                for i in idx..<(idx+numSeeds) {
                let dayOffset: Int = i - idx
                    let goal = Goal(id: nil,
                          title: "Title " + String(i),
                          description: "Description " + String(i),
                          dateCreated: Date().offsetBy(dayOffset, withUnit: .day).str(),
                          dateCompleted: "",
                          dateDue: Date().offsetBy(dayOffset, withUnit: .day).str())

                    try goal.insert(db)
                    let goalId = try Goal.fetchAll(db).last!.id
                    
                    let badge = Badge(id: nil,
                          goalId: goalId,
                          title: "Title " + String(i),
                          description: "Description " + String(i),
                          imageName: "badge",
                          dateEarned: (i % 2 == 0) ? Date().offsetBy(dayOffset, withUnit: .day).str() : "")
                    
                    try badge.insert(db)
//                    
//                    let zone = Zone(id: nil,
//                                    startTime: (i % 24).toHourStr(), endTime: (24 - i % 24).toHourStr(), date: Date().offsetBy(1, withUnit: .day).str(), notes: "notes", minutesUsed: 0)
//                    try zone.insert(db)
                }
            })
        }
    }
}
