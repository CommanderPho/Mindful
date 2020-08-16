//
//  ProfileChartView.swift
//  Mindful
//
//  Created by William Shelley on 7/5/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct ProfileChartView: View {
    
    var earnedTodayGoals: [Goal] {
        return DBM.all(Goal.self).filter { goal in goal.dateCompleted == Date().str() }
    }
    
    var goalPointMod: Int = 10
//    var todayPoints: Int = 10
    var todayPoints: Int {
        return self.earnedTodayGoals.count * goalPointMod
    }
//    var totalPoints: Int { return Int(pointsPerDay.reduce(0, +)) }
    var totalPoints: Int {
        return DBM.all(Goal.self).filter { goal in goal.dateCompleted.count > 0 }.count * goalPointMod
    }
    let bigCircleDim: CGFloat = SCREEN_WIDTH / 3
    let medCircleDim: CGFloat = SCREEN_WIDTH / 4
    let chartSpacing: CGFloat = 5
    
    
    let pointsPerDay: [CGFloat]
    let spacing: CGFloat
    let columns: Int = Date.weekdays.count
    
    private var maxPoints: CGFloat { return self.pointsPerDay.max() ?? 0}
    private let unitHeight: CGFloat = SCREEN_HEIGHT / 4
    private var unitWidth: CGFloat { return SCREEN_WIDTH / CGFloat(self.columns) - self.spacing }
    
    private var normalizedHeights: [CGFloat] {
        let max = self.maxPoints > 0 ? self.maxPoints : 30
        return pointsPerDay.map { (($0 > 0.0) ? ($0 + 1.0) : 1) / max }
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: self.spacing) {
            VStack(spacing: 10){
                Text("Points Earned Today")
                    .font(.title)
//                Spacer()
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(lineWidth: 5)
                        .foregroundColor(.blue)
                        .frame(width: self.bigCircleDim, height: self.bigCircleDim)
                    
                    Text(todayPoints.str())
                        .font(.largeTitle)
                }
            }
//            Spacer()
            VStack(spacing: self.spacing) {
                Text("Total Points")
                    .font(.title)
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(lineWidth: 5)
                        .foregroundColor(.blue)
                        .frame(width: self.medCircleDim, height: self.medCircleDim)
                    
                    Text(totalPoints.str())
                        .font(.largeTitle)
                }
            }
            Spacer()
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
