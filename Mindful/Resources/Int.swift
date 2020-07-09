//
//  Helpers.swift
//  Mindful
//
//  Created by William Shelley on 7/1/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import Foundation

extension Int {
    func month() -> String {
        let calendar = Calendar.current
        return calendar.monthSymbols[(self - 1) % calendar.monthSymbols.count]
    }
    
    func weekday() -> String {
        let calendar = Calendar.current
        return calendar.shortWeekdaySymbols[(self - 1) % calendar.shortWeekdaySymbols.count]
    }
    
    func str() -> String {
        return String(self)
    }
}

