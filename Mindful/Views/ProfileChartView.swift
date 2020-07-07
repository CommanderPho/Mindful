//
//  ProfileChartView.swift
//  Mindful
//
//  Created by William Shelley on 7/5/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct ProfileChartView: View {
    let pointsPerDay: [CGFloat]
    let spacing: CGFloat
    let columns: Int = Date.weekdays.count
    
    private var maxPoints: CGFloat { return self.pointsPerDay.max() ?? 0}
    private let unitHeight: CGFloat = SCREEN_HEIGHT / 4
    private var unitWidth: CGFloat { return SCREEN_WIDTH / CGFloat(self.columns) - self.spacing }
    
    private var normalizedHeights: [CGFloat] {
        let max = self.maxPoints
        return pointsPerDay.map { $0 / max }
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: self.spacing) {
            HStack(alignment: .bottom, spacing: self.spacing) {
                ForEach(self.normalizedHeights, id: \.self) { heightBase in
                    VStack(spacing: self.spacing) {
                        Text(String(Int(heightBase * self.maxPoints)))
                        
                    Rectangle()
                        .frame(width: self.unitWidth, height: heightBase * self.unitHeight)
                    }
                    
                }
            }
            WeekHeaderView(spacing: self.spacing)
        }
    }
}

struct ProfileChartView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileChartView(pointsPerDay: [5,2,20,4,35,6,3], spacing: 10)
    }
}
