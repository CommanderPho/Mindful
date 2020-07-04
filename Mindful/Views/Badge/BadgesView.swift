//
//  BadgesView.swift
//  Mindful
//
//  Created by William Shelley on 7/3/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct BadgesView: View {
    let badges: [[Badge]]
    let spacing: CGFloat
    
    var body: some View {
        ScrollView(showsIndicators: false){
            ZStack {
                VStack(alignment: .leading, spacing: self.spacing) {
                    ForEach(self.badges, id: \.self) { row in
                        BadgeRowView(row: row, spacing: self.spacing)
                    }
                }
            }
        }
    }
}

