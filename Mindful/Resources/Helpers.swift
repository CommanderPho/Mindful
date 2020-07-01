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
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale.autoupdatingCurrent
        return calendar.monthSymbols[(self - 1) % calendar.monthSymbols.count]
    }
    
    func weekday() -> String {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale.autoupdatingCurrent
        
        return calendar.shortWeekdaySymbols[(self - 1) % calendar.shortWeekdaySymbols.count]
    }
}

extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        return dateFormatter.date(from: self)!
    }
}

extension Date {
    func components() -> DateComponents {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year, .hour, .minute, .second, .weekday, .weekdayOrdinal], from: self)
        return components
    }
    
    func toStr() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        return dateFormatter.string(from: self)
    }
    
    func offsetBy(_ value: Int, withUnit: Calendar.Component) -> Date {
        return Calendar.current.date(byAdding: withUnit, value: value, to: self)!
    }
}
