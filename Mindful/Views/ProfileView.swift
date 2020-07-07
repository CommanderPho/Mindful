//
//  ProfileView.swift
//  Mindful
//
//  Created by William Shelley on 6/30/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    
    let pointsPerDay: [CGFloat] = [5,2,20,4,35,6,3]
    var todayPoints: Int = 10
    var totalPoints: Int { return Int(pointsPerDay.reduce(0, +)) }
    let bigCircleDim: CGFloat = SCREEN_WIDTH / 3
    let medCircleDim: CGFloat = SCREEN_WIDTH / 4
    let spacing: CGFloat = 10
    let chartSpacing: CGFloat = 5
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: self.spacing) {
                VStack(spacing: self.spacing){
                    Text("Points Earned Today")
                        .font(.title)
                    Spacer()
                    ZStack(alignment: .center) {
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(lineWidth: 5)
                            .foregroundColor(.blue)
                            .frame(width: self.bigCircleDim, height: self.bigCircleDim)
                        
                        Text(todayPoints.str())
                            .font(.largeTitle)
                    }
                }
                Spacer()
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
                
                VStack(spacing: self.spacing) {
                    Divider()
                    ProfileChartView(pointsPerDay: self.pointsPerDay, spacing: self.chartSpacing)
                    Divider()

//                    VStack {
//                        ProfileRowView(left: "Points")
//                        ProfileRowView(left: "Badges")
//                        ProfileRowView(left: "Goals")
//                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
