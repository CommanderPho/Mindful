//
//  AwarenessZone.swift
//  Mindful
//
//  Created by William Shelley on 7/9/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

struct Zone: ApplicationRecord {
    var id: Int64?
    
    var startTime: String
    var endTime: String
    var date: String
    var notes: String
    var minutesUsed: Int
}
