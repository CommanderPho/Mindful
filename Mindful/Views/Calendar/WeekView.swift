//
//  WeekView.swift
//  Mindful
//
//  Created by William Shelley on 7/3/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct WeekView: View {
    let week: [Date]
    let spacing: CGFloat
    var body: some View {
        HStack(spacing: self.spacing) {
            ForEach(self.week, id: \.self) { day in
                NavigationLink(destination: DayView(date: day)) {
                    // blue if some goals red if no goals
                    DateCell(date: day, spacing: self.spacing)
                }
            }
        }
    }
}
