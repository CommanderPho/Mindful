//
//  BadgeCell.swift
//  Mindful
//
//  Created by William Shelley on 7/4/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct BadgeCell: View {
    @Environment(\.colorScheme) var colorScheme
    @State var badge: Badge
    let spacing: CGFloat
    @Binding var isPresenting: Bool
    @State private var presentingBadge: Bool = false
    
    private var dim: CGFloat { return BADGES_CELL_DIM - self.spacing }
    private let height: CGFloat = BADGES_CELL_HEIGHT
    
    var body: some View {
        VStack {
            Image(badge.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .saturation(badge.dateEarned.isEmpty ? 0 : 1)
                .padding()
            
            Text(badge.title)
                .font(.footnote)
        }
        .frame(width: self.dim, height: self.height)
        .overlay(
            BADGES_CELL_BORDER_SHOWING
                ? RoundedRectangle(cornerRadius: BADGES_CELL_CORNER_RADIUS)
                    .stroke(lineWidth: BADGES_CELL_BORDER_LINE_WIDTH)
                : nil)
            .onTapGesture(perform: { self.presentingBadge.toggle() })
            .sheet(isPresented: self.$presentingBadge) { BadgeView(badge: self.$badge, isComplete: self.badge.isEarned()) }
    }
}
