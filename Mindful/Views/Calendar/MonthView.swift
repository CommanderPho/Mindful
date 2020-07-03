//
//  CalendarView.swift
//  Mindful
//
//  Created by William Shelley on 6/30/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct MonthView: View {
    let month: [[Date]]
    let spacing: CGFloat

    var body: some View {
        VStack(alignment: .trailing) {
            WeekView(week: self.month.first!, spacing: self.spacing)
                .padding(.bottom, self.spacing)
            VStack(alignment: .leading, spacing: self.spacing) {
                ForEach(self.month[1..<self.month.count], id: \.self) { week in
                    WeekView(week: week, spacing: self.spacing)
                }
            }
        }
        
    }
}
