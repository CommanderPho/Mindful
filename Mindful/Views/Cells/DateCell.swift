//
//  DateCell.swift
//  Mindful
//
//  Created by William Shelley on 7/1/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct DateCell: View {
    
    let date: Date //= DBM.all(Day.self).first!
    
    var body: some View {
        VStack {
//            Text(String(date.components().month!.month()))
            Text(String(date.components().weekday!.weekday()))
            Text(String(date.components().day!))
//            Text(String(numDaysInMonth(date)))
            
//            Text(String(ordinality(date).weekday()))
            
//            Text(String(numDaysInMonth(date)))
//            Text("Day")
//            Text(date.toStr())
            
//            Text(Date().toStr())
//            Text(advanceDate(n: -1, from: Date()))
//            Text(String(Date().components().month!))
//            Text(String(Date().components().day!))
//            Text(String(Date().components().year!))
//            Text(String(Date().offsetBy(0, withUnit: .day).components().weekday!.weekday()))
//            Text(String(Date().offsetBy(0, withUnit: .day).components().month!.month()))
//            Text(String(Date().components().weekdayOrdinal!))
            
        }
    }
}
