//
//  ProfileRow.swift
//  Mindful
//
//  Created by William Shelley on 6/30/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct ProfileRow: View {
    
    var left: String = "Left"
    var middle: String = "Middle"
    var body: some View {
        VStack {
            Divider()
            HStack {
                Text(left)
                Text(middle)
                Image(systemName: "chevron.right")
                .resizable()
                .frame(width: 24, height: 24)
            }
        }
    }
}
