//
//  DBManager.swift
//  Mindful
//
//  Created by William Shelley on 6/26/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import Foundation
import GRDB

//var DBConnection: DatabaseQueue?
var dbQueue: DatabaseQueue?

func insert(){
    try! dbQueue?.write({ db in
        let today = Day(id: nil, date: "06/25/2020")
        let tmrw = Day(id: nil, date: "06/26/2020")
        
        try today.insert(db)
        try tmrw.insert(db)
        
        let days = try Day.fetchAll(db)
        for day in days {
            print(day.id, day.date)
        }
        print(days)
    })
    print("insertion")
    
}

//Mindful/Mindful/Models/DBManager.swift
// ../Resources/db.sqlite
//Mindful/Mindful/Resources
