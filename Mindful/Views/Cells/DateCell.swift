//
//  DateCell.swift
//  Mindful
//
//  Created by William Shelley on 7/1/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct DateCell: View {
    
    let date: Date //= DBM.all(Day.self).first!
    let pad: CGFloat = 10
    
    var body: some View {
        
        GeometryReader { g in
            HStack(alignment: .center){
        VStack {
            Text(String(self.date.components().weekday!.weekday()))
                .font(.system(size: max(g.size.width * 0.4, g.size.height * 0.4)))
            Text(String(self.date.components().day!))
        }
            }
        }.frame(width: screenWidth / 8, height: screenWidth / 8)
    }
}
