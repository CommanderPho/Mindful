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
//    @State var showingDay: Bool = true
    
    private var nextMonthDate: Date {
        return self.focusDate.firstInMonth().offsetBy(1, withUnit: .month)
    }
    
    private var lastMonthDate: Date {
        return self.focusDate.firstInMonth().offsetBy(-1, withUnit: .month)
    }
    
    private func lastMonth() {
        withAnimation(.easeInOut(duration: CALENDAR_ANIMATION_DURATION)) {
            self.focusDate = lastMonthDate
        }
    }
    
    private func nextMonth() {
        withAnimation(.easeInOut(duration: CALENDAR_ANIMATION_DURATION)) {
            self.focusDate = nextMonthDate
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center){
                Text(focusDate.month).padding(.bottom, self.spacing)
                    .font(.largeTitle)
                
                Divider()
                
                WeekHeaderView(spacing: self.spacing)
                
                Divider()
                
                MonthView(month: focusDate.createMonthArray2D(), spacing: self.spacing)
            
                    
                NavigationLink(destination: DayView(date: Date())){
                    Text("Today")
                }.simultaneousGesture(TapGesture().onEnded {
                    self.focusDate = Date()
                })

            }
            .navigationBarTitle(focusDate.year.str())
            .navigationBarItems(
                leading: Button(self.lastMonthDate.month) { self.lastMonth() },
                trailing: Button(self.nextMonthDate.month) { self.nextMonth() }
            )
                .gesture(DragGesture().onEnded({swipe in
                    let swipeDistance: CGFloat = swipe.location.x - swipe.startLocation.x
//                    let swipeDistance: CGFloat = swipe.location.y - swipe.startLocation.y
                    let minSwipeDistance: CGFloat = 100
                    let minDistanceMet: Bool = abs(swipeDistance) > minSwipeDistance
                    
                    if minDistanceMet {
                        if swipeDistance > 0 {
                            // left
                            self.lastMonth()
                        } else if swipeDistance < 0 && abs(swipeDistance) > minSwipeDistance {
                            // right
                            self.nextMonth()
                        }
                    }
                }))
                .transition(.slide)
            
        }
    }
}
