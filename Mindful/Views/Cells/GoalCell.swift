//
//  GoalCell.swift
//  Mindful
//
//  Created by William Shelley on 6/30/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct GoalCell: View {
    let goal: Goal
    
    var body: some View {
        NavigationLink(destination: GoalView(goal: goal)){
            HStack {
                Text(goal.title)
                Spacer()
                VStack(alignment: .center) {
                    Text(goal.description)
                    Text(goal.status)
                }
            }
        }
    }
}
//
//struct GoalCell_Previews: PreviewProvider {
//    static var previews: some View {
//        GoalCell(goal:
//            Goal(id: nil, title: "Goal Title", description: "Goal Description",
//                 status: "COMPLETE",
//                 dateCreated: Date().str(),
//                 dateCompleted: Date().offsetBy(-1, withUnit: .day).str(),
//                 dateDue: Date().offsetBy(1, withUnit: .day).str()
//            ))
//    }
//}
