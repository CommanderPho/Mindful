//
//  DaysCollection.swift
//  Mindful
//
//  Created by William Shelley on 6/30/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct DaysCollection: View {

    let numCols: Int
    let spacing: CGFloat
    let days: [Day] = DBM.all(Day.self)
    
    var body: some View {
        GridView<Day, DayCell>(numCols: numCols, spacing: spacing, data: days) { item, width, height in
            DayCell(item: item, width: width, height: height)
        }
    }
}
