//
//  CalendarView.swift
//  Mindful
//
//  Created by William Shelley on 6/30/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct CalendarView: View {
    // simplistic approach:
    // each month has 5 rows with 7 columns (5 weeks and 7 days per week)
    // each week will have 7 slots [Sa,M,T,W,Th,F,Su]
    // each day will be 1 unit
    
    
    var body: some View {
        Text("Calendar")
    }
}

struct MonthView: View {
    
    let focusDate: Date
    
    let spacing: CGFloat = 25

    private var month: [[Date]] {
        var dates: [[Date]] = [[Date]()]
        let daysInMonth = numDaysInMonth(focusDate)
        var day = firstDateInMonth(focusDate)
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale.autoupdatingCurrent
        
        var daysAhead = 0
        
        while day.components().weekday!.weekday() != calendar.shortWeekdaySymbols[0] {
            dates[dates.count-1].append(day)
            day = day.offsetBy(1, withUnit: .day)
            daysAhead += 1
        }
        
        if daysAhead > 0 { dates.append([]) }
        
        for i in 0..<daysInMonth {
            if i % 7 == 0 && i > 0 {
                dates.append([])
            }
            dates[dates.count-1].append(day)
            day = day.offsetBy(1, withUnit: .day)
        }
        return dates
    }
    
    var body: some View {
        VStack(alignment: .center){
            Text(String(focusDate.components().month!.month())).padding(.bottom, self.spacing * 2)
            VStack(alignment: .trailing) {
                WeekView(week: self.month.first!, spacing: self.spacing).padding(.bottom, self.spacing)
                VStack(alignment: .leading, spacing: self.spacing) {
                    ForEach(self.month[1..<self.month.count], id: \.self) { week in
                        WeekView(week: week, spacing: self.spacing)
                    }
                }
            }
        }
    }
}

struct WeekView: View {
    
    let week: [Date]
    let spacing: CGFloat
    var body: some View {
        HStack(spacing: self.spacing) {
            ForEach(self.week, id: \.self) { day in
                DayView(date: day)
            }
        }
    }
}



struct DayView: View {
    
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


private func firstDateInMonth(_ date: Date) -> Date {
    let offset = 1-date.components().day!
    let firstDayInMonth = date.offsetBy(offset, withUnit: .day)
//    print(firstDayInMonth)
    return firstDayInMonth
}

private func numDaysInMonth(_ dateToCheck: Date) -> Int {
    let cal = Calendar(identifier: .gregorian)
    let range = cal.range(of: .day, in: .month, for: Date())
    return range!.count
}

private func ordinality(_ date: Date) -> Int {
    let cal = Calendar(identifier: .gregorian)
//    print(cal.weekdaySymbols)
//    let ord = cal.ordinality(of: .day, in: .month, for: Calendar.current.date(byAdding: .day, value: -7, to: date)!)
    let ord = cal.ordinality(of: .day, in: .weekOfYear, for: date)
    return ord!
}

private func advanceDate(n days: Int, from date: Date) -> String {
    let newDay = Calendar.current.date(byAdding: .day, value: days, to: date)!.toStr()
    return newDay
}
