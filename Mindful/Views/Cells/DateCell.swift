//
//  DateCell.swift
//  Mindful
//
//  Created by William Shelley on 7/1/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct DateCell: View {
    @State var date: Date
    @State var isEmpty: Bool = true
    @Environment(\.colorScheme) var colorScheme
    
    let spacing: CGFloat
    private var dim: CGFloat {
        return CALENDAR_CELL_DIM - self.spacing
    }
    
    var body: some View {
        Text(self.date.components.day!.str())
        .frame(width: self.dim, height: self.dim)
        .onAppear(perform: { self.isEmpty = self.date.goals().isEmpty })
        .foregroundColor(self.isEmpty ? .red : .blue)
        .overlay(
            RoundedRectangle(cornerRadius: CALENDAR_CELL_CORNER_RADIUS)
                .stroke(lineWidth: 1)
        )
        .foregroundColor(colorScheme == .dark ? .white : .secondary)
    }
}
