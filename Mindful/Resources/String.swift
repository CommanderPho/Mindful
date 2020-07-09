//
//  String.swift
//  Mindful
//
//  Created by William Shelley on 7/9/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import Foundation

extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Calendar.current.locale?.identifier ?? "en_US_POSIX")
        dateFormatter.dateFormat = DATE_FORMAT
        return dateFormatter.date(from: self)!
    }
}
