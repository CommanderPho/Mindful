//
//  Date.swift
//  Mindful
//
//  Created by William Shelley on 7/9/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import Foundation

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
    
    static func minsBetween(start: String, end: String) -> Int {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "HH:mm"
//        dateFormatter.locale = Locale(identifier: Calendar.current.locale?.identifier ?? "en_US_POSIX")
        let dateFormatter = Date.createFormatter(format: "HH:mm")

        let s = dateFormatter.date(from: start)
        let e = dateFormatter.date(from: end)

        let timeInterval = e!.timeIntervalSince(s!)
        return Int(timeInterval / 60)
    }
    
    static func createFormatter(format: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: Calendar.current.locale?.identifier ?? "en_US_POSIX")
        return dateFormatter
    }
    
    func timeStr() -> String {
        let dateFormatter = Date.createFormatter(format: "HH:mm")
        return dateFormatter.string(from: self)
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
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: Calendar.current.locale?.identifier ?? "en_US_POSIX")
//        dateFormatter.dateFormat = DATE_FORMAT
        let dateFormatter = Date.createFormatter(format: DATE_FORMAT)
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
