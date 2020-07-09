//
//  BadgesView.swift
//  Mindful
//
//  Created by William Shelley on 7/3/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct BadgeGridView: View {
    @Binding var badges: [[Badge]]
    let spacing: CGFloat
    
    var body: some View {
        ZStack {
            VStack {
                ForEach(self.badges, id: \.self) { row in
                    BadgeRowView(row: row, spacing: self.spacing)
                }
            }
        }
        .foregroundColor(.accentColor)
    }
}

