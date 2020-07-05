//
//  ProfileRow.swift
//  Mindful
//
//  Created by William Shelley on 6/30/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct ProfileRowView: View {
    
    var left: String = "Left"
    
    var body: some View {
        VStack {
            Divider()
            HStack {
                Text(left)
                Spacer()
                Image(systemName: "chevron.right")                
            }
        }
    }
}
