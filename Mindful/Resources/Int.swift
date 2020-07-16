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
    
    func toHourStr() -> String {
        let halfDay: Int = 12
        let fullDay: Int = halfDay * 2
        if (self == 0) {
            return "Morning"
        } else if (self < halfDay && self > 0) {
            return self.str() + " AM"
        } else if (self == halfDay) {
            return "Noon"
        } else if (self > halfDay && self < fullDay) {
            return (self - halfDay).str() + " PM"
        } else if (self == fullDay) {
            return "Midnight"
        } else {
            return "Time does not exist."
        }
    }
}

