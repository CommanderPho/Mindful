//
//  BadgesView.swift
//  Mindful
//
//  Created by William Shelley on 7/3/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct BadgeGridView: View {
    let badges: [[Badge]]
    let spacing: CGFloat
    @State var isPresenting: Bool = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: self.spacing) {
                ForEach(self.badges, id: \.self) { row in
                    BadgeRowView(row: row, spacing: self.spacing, isPresenting: self.$isPresenting)
                }
            }
        }
        .foregroundColor(.accentColor)
    }
}

