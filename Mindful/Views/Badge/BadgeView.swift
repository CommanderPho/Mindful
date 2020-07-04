//
//  BadgeView.swift
//  Mindful
//
//  Created by William Shelley on 7/4/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct BadgeView: View {
    let badge: Badge
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(badge.title)
                .font(.largeTitle)
            
            Spacer()
            
            Image(badge.imageName)
                .scaleEffect(3)
            
            Spacer()
            
            Text(badge.description)
            
            Spacer()
            
            Text(badge.dateEarned)
            
            Spacer()
        }
    }
}
