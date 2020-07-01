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
    // possible fix to slow loading:
    //  have currentWeeks be a @State variable [[Date]]
    //  on scroll up, remove last week and add previous week ?
    
    let focusDate: Date = Date()
    let rangeOfMonths: Int = 12 // n / 2 behind, n / 2 forward -> ideally, now it is just n in the future
    let spacing: CGFloat = 5
    
    private var monthStartDates: [Date] {
        var dates: [Date] = []
        var date = focusDate
        let futurerRange = 0..<rangeOfMonths
        for _ in futurerRange {
            dates.append(date)
            date = date.offsetBy(1, withUnit: .month) // go to next month
        }
        
        return dates
    }
    
    var body: some View {
        
//        List(self.monthStartDates, id: \.self){ date in
                        NavigationView {
//            Section {
//                HStack {
//                    MonthView(focusDate: date, spacing: self.spacing)
//                    }
//                }
//            }
//             slow loading:
            ScrollView(showsIndicators: false){
                    ForEach(self.monthStartDates, id: \.self) { date in
                        MonthView(focusDate: date, spacing: self.spacing)
                    }.padding(.bottom, self.spacing * 2)
            }.navigationBarTitle( Text("Calendar") )

            }
    }
}

struct MonthView: View {
    let focusDate: Date
    let spacing: CGFloat
    
    private var month: [[Date]] {
        var dates: [[Date]] = [[Date]()]
        let daysInMonth = focusDate.numDays(in: .month)
        var day = focusDate.firstInMonth()
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale.autoupdatingCurrent
        
        var daysAhead = 0
        
        while day.components().weekday!.weekday() != calendar.shortWeekdaySymbols[0] {
            dates[dates.count-1].append(day)
            day = day.offsetBy(1, withUnit: .day)
            daysAhead += 1
        }
        
        if daysAhead > 0 { dates.append([]) }
        
        for i in 0..<daysInMonth-daysAhead {
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
            Text(String(focusDate.components().month!.month())).padding(.bottom, self.spacing).foregroundColor(.black)
            VStack(alignment: .trailing) {
                WeekView(week: self.month.first!, spacing: self.spacing)
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
        
        
        HStack(spacing: 3) {
            
            ForEach(self.week, id: \.self) { day in
                NavigationLink(destination: GoalsView(date: day)) {
                    // blue if some goals red if no goals
                    DateCell(date: day).foregroundColor(day.goals().isEmpty ? .red : .blue)
                    //                        .frame(width: 25, height: 25)
                    //                        .frame(width: 25 + 10, height: 25 + 10)
                    
                }
                    //                }.listStyle(PlainListStyle())
                    //                .buttonStyle(PlainButtonStyle())
                    //                .padding(10)
                    .border(Color.black)
            }
        }
    }
}
