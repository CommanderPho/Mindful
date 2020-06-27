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

//func insert() {
//    guard let dbQueue = dbQueue else { print("dbQueue invalid"); return; }
    
//    try? dbQueue.write({ db in
//        let format = DateFormatter()
//        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let formattedDate = format.string(from: Date())
//        let now = Day(id: nil, date: formattedDate)
//
//
//        try now.insert(db)
//        let days = try Day.fetchAll(db)
//        let day = days.last!
//
//        print("inserted: ", day.id!, day.date)
//
//
//        let goal = Goal(id: nil, userId: 1,
//                        description: "this is a goal",
//                        status: "INCOMPLETE",
//                        createdDayId: day.id!,
//                        completedDayId: day.id!,
//                        deadlineDayId: day.id!)
//
//        try goal.insert(db)
//        let goals = try Goal.fetchAll(db)
//
//        print("inserted: ", goals.last!.id!, goals.last!.description)
//
//        let badge = Badge(id: nil, goalId: goal.id, dayId: day.id, description: "a badge", imageName: "badge")
//        try badge.insert(db)
//        let badges = try Badge.fetchAll(db)
//
//        print("inserted: ", badges.last!.id!, badges.last!.description)
//    })
    
//    try? dbQueue.read({ db in
//        let day = try Day.fetchAll(db).first!
//        print(day)
//        let goalsDue = try day.goalsDue.fetchAll(db)
//        print(goalsDue)
//        let goal = goalsDue.first!
//        print(goal)
//        let dayCreated = try goal.dayCreated.fetchOne(db)
//        print(dayCreated)
//
//    })
//}
