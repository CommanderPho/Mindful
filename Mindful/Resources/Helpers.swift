//
//  Helpers.swift
//  Mindful
//
//  Created by William Shelley on 7/1/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import Foundation

let dateFormat = "yyyy-MM-dd" //' 'HH:mm:ss

extension Int {
    func month() -> String {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale.autoupdatingCurrent
        return calendar.monthSymbols[(self - 1) % calendar.monthSymbols.count]
    }
    
    func weekday() -> String {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale.autoupdatingCurrent
        
        return calendar.shortWeekdaySymbols[(self - 1) % calendar.shortWeekdaySymbols.count]
    }
    
    func str() -> String {
        return String(self)
    }
}

extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: self)!
    }
}

extension Date {
    func firstInMonth() -> Date {
        let offset = 1-self.components().day!
        let firstDayInMonth = self.offsetBy(offset, withUnit: .day)
        return firstDayInMonth
    }
    
    func numDays(in component: Calendar.Component) -> Int {
        let cal = Calendar(identifier: .gregorian)
        let range = cal.range(of: .day, in: component, for: self)
        return range!.count
    }
    
    func components() -> DateComponents {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year, .hour, .minute, .second, .weekday, .weekdayOrdinal], from: self)
        return components
    }
    
    func str() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
    
    func offsetBy(_ value: Int, withUnit: Calendar.Component) -> Date {
        return Calendar.current.date(byAdding: withUnit, value: value, to: self)!
    }
    
    func goals() -> [Goal] {
        var found: [Goal] = []
        let string = self.str()
        try? dbQueue?.read({ db in
            found = try Goal
                .filter(sql: "dateDue = ?",
                        arguments: [string])
                .fetchAll(db)
        })
        return found
    }
    
    func formatted() -> String {
        let components = self.components()
        let weekday = components.weekday!.weekday()
        let month = components.month!.month()
        let dayInMonth = components.day!
        let year = components.year!
        return weekday + ", " + month + " " + String(dayInMonth) + ", " + String(year)
    }
}
