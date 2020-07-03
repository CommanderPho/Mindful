//
//  CalendarView.swift
//  Mindful
//
//  Created by William Shelley on 7/3/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct CalendarView: View {
    @State var focusDate: Date
    let spacing: CGFloat
    
    private var nextMonthDate: Date {
        return self.focusDate.firstInMonth().offsetBy(1, withUnit: .month)
    }
    
    private var lastMonthDate: Date {
        return self.focusDate.firstInMonth().offsetBy(-1, withUnit: .month)
    }
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false){
                VStack(alignment: .center){
                    Text(focusDate.month).padding(.bottom, self.spacing).foregroundColor(.black)
                        .font(.largeTitle)
                    Divider()
                    
                    WeekHeader(spacing: self.spacing)
                    
                    Divider()
                    
                    MonthView(month: focusDate.createMonthArray2D(), spacing: self.spacing)
                }
                .navigationBarTitle(focusDate.year.str())
                .navigationBarItems(
                    leading: Button(self.lastMonthDate.month, action: {
                        self.focusDate = self.lastMonthDate
                    }),
                    trailing: Button(self.nextMonthDate.month, action: {
                        self.focusDate = self.nextMonthDate
                    }))
            }
        }
    }
}
