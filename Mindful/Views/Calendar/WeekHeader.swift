//
//  WeekHeader.swift
//  Mindful
//
//  Created by William Shelley on 7/3/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct WeekHeader: View {
    let spacing: CGFloat
    var body: some View {
        HStack(spacing: self.spacing) {
            ForEach(Date.weekdays, id: \.self) { day in
                WeekHeaderCell(weekday: day, spacing: self.spacing)
            }
        }
    }

}
