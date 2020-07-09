//
//  Helpers.swift
//  Mindful
//
//  Created by William Shelley on 7/1/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import Foundation

let dateFormat = "yyyy-MM-dd"
let dateLength = dateFormat.count

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

extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Calendar.current.locale?.identifier ?? "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: self)!
    }
}

extension Date {
    static var weekdays: [String] {
        let calendar = Calendar.current
        return calendar.shortWeekdaySymbols
    }
    
    static var shortWeekdays: [String] {
        let calendar = Calendar.current
        return calendar.veryShortWeekdaySymbols
    }
    
    var components: DateComponents {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year, .hour, .minute, .second, .weekday, .weekdayOrdinal], from: self)
        return components
    }
    
    var weekday: String {
        return self.components.weekday!.weekday()
    }
    
    var month: String {
        return self.components.month!.month()
    }
    
    var year: Int {
        return self.components.year!
    }
    
    func firstInMonth() -> Date {
        let offset = -(self.components.day! - 1)
        let firstDayInMonth = self.offsetBy(offset, withUnit: .day)
        return firstDayInMonth
    }
    
    func numDays(in component: Calendar.Component) -> Int {
        let range = Calendar.current.range(of: .day, in: component, for: self)
        return range!.count
    }
    
    func str() -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: Calendar.current.locale?.identifier ?? "en_US_POSIX")
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
        let components = self.components
        let weekday = components.weekday!.weekday()
        let month = components.month!.month()
        let dayInMonth = components.day!
        let year = components.year!
        return weekday + ", " + month + " " + String(dayInMonth) + ", " + String(year)
    }
    
    func createMonthArray2D() -> [[Date]] {
        // createMonth() = [Week[Day]]
        
        var dates: [[Date]] = [[Date]()]

        let daysInMonth = self.numDays(in: .month)
        
        var day = self.firstInMonth()
        
        let calendar = Calendar.current
        while day.weekday != calendar.shortWeekdaySymbols[0] {
            let lastIdx = dates.count - 1
            dates[lastIdx].append(day)
            day = day.offsetBy(1, withUnit: .day)
        }
        
        let numFirstWeekDays = dates[0].count
        
        if numFirstWeekDays > 0 { dates.append([]) }
        
        let numWeekDays = Date.weekdays.count
        
        let remainingDays = daysInMonth-numFirstWeekDays
        for _ in 0..<remainingDays {
            var lastIdx = dates.count - 1
            
            if dates[lastIdx].count >= numWeekDays {
                dates.append([])
                lastIdx = dates.count - 1
            }
            dates[lastIdx].append(day)
            
            day = day.offsetBy(1, withUnit: .day)
        }
        
        return dates
    }
}

extension Badge {
    static func all2DArray(columns: Int) -> [[Badge]] {
        return Badge.make2D(DBM.all(Badge.self), columns: columns)
    }
    
    static func make2D(_ badges: [Badge], columns: Int) -> [[Badge]] {
        var rows:[[Badge]] = [[Badge]()]
        
        for badge in badges {
            var lastRowIdx: Int = rows.count - 1
            if rows[lastRowIdx].count >= columns {
                rows.append([])
                lastRowIdx = rows.count - 1
            }
            rows[lastRowIdx].append(badge)
        }
        return rows
    }
    
    func isEarned() -> Bool {
        return !self.dateEarned.isEmpty
    }
}

extension Goal {
    func isComplete() -> Bool {
        return !self.dateCompleted.isEmpty
    }
}
