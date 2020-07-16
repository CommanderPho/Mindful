//
//  DateCell.swift
//  Mindful
//
//  Created by William Shelley on 7/1/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct DateCell: View {
    @Environment(\.colorScheme) var colorScheme
    @State var date: Date
    @State var isEmpty: Bool = true
    
    let spacing: CGFloat
    private var dim: CGFloat { return CALENDAR_CELL_DIM - self.spacing }
    private let height: CGFloat = CALENDAR_CELL_HEIGHT
    private let dotScale: CGFloat = 0.5
    private let highlightScale: CGFloat = 1.5
    private let verticalItemSpacing: CGFloat = 0
    private var isToday: Bool { return self.date.str() == Date().str() }
    private var fontColor: Color { return colorScheme == .dark ? .white : .secondary }
    
    var body: some View {
        NavigationLink(destination: DayView(date: self.date)) {
        VStack(alignment: .center, spacing: self.verticalItemSpacing) {
            Spacer()
            ZStack(alignment: .center) {
                Image.init(systemName: "circle.fill")
                    .foregroundColor(self.isToday ? .red : .clear)
                    .scaleEffect(self.highlightScale)
                Text(self.date.components.day!.str())
                    .frame(width: self.dim)
                    .foregroundColor(self.isToday ? .white : self.fontColor)
            }
            Spacer()
            Image.init(systemName: "circle.fill")
                .foregroundColor(self.isEmpty ? .clear : .accentColor)
                .scaleEffect(self.dotScale)
            Spacer()
        }
        .frame(width: self.dim, height: self.height)
        .onAppear(perform: { self.isEmpty = self.date.goals().isEmpty })
        .overlay(
            CALENDAR_CELL_BORDER_SHOWING
                ? RoundedRectangle(cornerRadius: CALENDAR_CELL_CORNER_RADIUS)
                    .stroke(lineWidth: CALENDAR_CELL_BORDER_LINE_WIDTH)
                : nil
        )
            .foregroundColor(self.fontColor)
        }
    }
}
