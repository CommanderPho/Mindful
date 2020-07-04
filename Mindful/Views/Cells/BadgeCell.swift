//
//  BadgeCell.swift
//  Mindful
//
//  Created by William Shelley on 7/4/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct BadgeCell: View {
    let badge: Badge
    let spacing: CGFloat
    
    @Environment(\.colorScheme) var colorScheme
    
    private var dim: CGFloat {
        return BADGES_CELL_DIM - self.spacing
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(badge.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .saturation(badge.dateEarned.isEmpty ? 0 : 1)
            
            Text(badge.title)
                .font(.footnote)
        }
        .frame(width: self.dim, height: self.dim)
        .overlay(
            RoundedRectangle(cornerRadius: BADGES_CELL_CORNER_RADIUS)
                .stroke(lineWidth: 1)
                .foregroundColor(colorScheme == .dark ? .white : .secondary)
        )
    }
}
