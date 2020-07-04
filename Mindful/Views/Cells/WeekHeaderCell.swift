//
//  WeekHeaderCell.swift
//  Mindful
//
//  Created by William Shelley on 7/3/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct WeekHeaderCell: View {
    @Environment(\.colorScheme) var colorScheme
    let weekday: String
    let spacing: CGFloat
    
    private var dim: CGFloat { return CALENDAR_CELL_DIM - self.spacing }
    
    var body: some View {
        Text(self.weekday)
        .frame(width: self.dim, height: self.dim)
        .overlay(WEEKHEADER_CELL_BORDER_SHOWING
            ? RoundedRectangle(cornerRadius: CALENDAR_CELL_CORNER_RADIUS)
                .stroke(lineWidth: CALENDAR_CELL_BORDER_LINE_WIDTH)
            : nil)
    }
}
