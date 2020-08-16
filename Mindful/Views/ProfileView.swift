//
//  ProfileView.swift
//  Mindful
//
//  Created by William Shelley on 6/30/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    
    var pointsEarnedPerGoalComplete: CGFloat = 10
    
    var pointsPerDay: [CGFloat] {
        var dates: [Date] = []
        var idx = 1
        while idx < 8 {
            dates.append(Date().offsetBy(idx, withUnit: .day))
            idx += 1
        }
        var pointsArr: [CGFloat] = []
        for date in dates {
            let filteredGoals: [Goal] = date.goals().filter { goal in goal.dateCompleted == date.str() }
            
            pointsArr.append(CGFloat(filteredGoals.count) * pointsEarnedPerGoalComplete)
        }
        
        return pointsArr
    }
    
//    let pointsPerDay: [CGFloat] = [5,2,20,4,35,6,3]
    var todayPoints: CGFloat { return CGFloat(Date().goals().filter { goal in goal.dateCompleted == Date().str() }.count) * self.pointsEarnedPerGoalComplete }
    var totalPoints: Int { return Int( todayPoints + pointsPerDay.reduce(0, +)) }
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
            let allGoals = DBM.all(Goal.self)
            var uniqueTitles = Set<String>()
            var uniqueGoals: [Goal] = []
            for goal in allGoals {
                if !uniqueTitles.contains(goal.title) {
                    uniqueTitles.insert(goal.title)
                    uniqueGoals.append(goal)
                }
            }
            self.goals = uniqueGoals
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
