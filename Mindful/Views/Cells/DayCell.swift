//
//  DayCell.swift
//  Mindful
//
//  Created by William Shelley on 6/30/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct DayCell: GridCell, View {
    var item: Day
    var width: CGFloat
    var height: CGFloat
    
    typealias AR = Day
    
    var body: some View {
        VStack {
        Text(String(self.item.date.toDate().components().day!))
            .background(Image(systemName: "app").resizable()).padding(10)
        }
//        VStack {
//            Text(String(self.item.date.toDate().components().day!))
//                .background(Image(systemName: "app").resizable())
//
//        }
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
        let components = calendar.dateComponents([.day, .month, .year, .hour, .minute, .second, .weekday], from: self)
        return components
    }
}
