//
//  BadgeRowView.swift
//  Mindful
//
//  Created by William Shelley on 7/4/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct BadgeRowView: View {
    let row: [Badge]
    let spacing: CGFloat
    @State var modalShowBadge: Badge?
    @Binding var isPresenting: Bool
    
    var body: some View {
        HStack(spacing: self.spacing) {
            ForEach(row, id: \.self) { badge in
                BadgeCell(badge: badge, spacing: self.spacing, isPresenting: self.$isPresenting)
            }
        }
    }
}
