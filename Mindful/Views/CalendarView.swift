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
    
    private let numWeeks: Int = 5 // number of rows per month
    
    var body: some View {
        Text("Month")
    }
}

struct WeekView: View {
    
    private let numDays: Int = 7 // number of days in a week
    
    var body: some View {
        Text("Week")
    }
}

struct DayView: View {
    
    let day: Day
    
    var body: some View {
        VStack {
            Text("Day")
        }
    }
}



struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
