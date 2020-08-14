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
    
    let insets: EdgeInsets = EdgeInsets(top: 0, leading: SCREEN_WIDTH / 15, bottom: 0, trailing: SCREEN_WIDTH / 15)
    
    @State var goals: [Goal] = DBM.all(Goal.self)
    
    var body: some View {
        NavigationView {
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center, spacing: self.spacing) {
                    Image("cat")
                        .frame(width: SCREEN_WIDTH, height: SCREEN_HEIGHT/2)
                        .scaleEffect(0.3)
                    Spacer()
                    VStack(spacing: self.spacing) {
                        Divider()
                        NavigationLink(destination: ProfileChartView(pointsPerDay: self.pointsPerDay, spacing: self.chartSpacing)) {
                            HStack(spacing: self.spacing) {
                                Text("Points")
                                
                                Image(systemName: "star.fill")
                                Spacer()
                                Text(self.totalPoints.str())
                            }.padding(self.insets)
                        }
                        Divider()
                        NavigationLink(destination: AllBadgesView()) {
                            HStack(spacing: self.spacing) {
                                Text("Badges")
                                
                                Image(systemName: "rosette")
                                Spacer()
                            }.padding(self.insets)
                        }
                        Divider()
                        //                    NavigationLink(destination: GoalsListView(date: Date())) {
                        NavigationLink(destination: GoalsListFromGoalsView(goals: self.goals)) {
                            HStack(spacing: self.spacing) {
                                Text("Goals")
                                
                                Image(systemName: "list.number")
                                Spacer()
                            }.padding(self.insets)
                        }
                        Divider()
                    }
                }
            }
        }
        .onAppear() {
            self.goals = DBM.all(Goal.self)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
