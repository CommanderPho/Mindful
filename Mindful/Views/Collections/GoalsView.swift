//
//  GoalsTable.swift
//  Mindful
//
//  Created by William Shelley on 6/30/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct GoalsView: View {
    @State var date: Date
    private var goals: [Goal] {
        return date.goals()
    }
    
    var body: some View {
        List(self.goals) { goal in
            GoalCell(goal: goal)
        }
        .navigationBarTitle(Text(date.formatted()), displayMode: .inline)
        .navigationBarItems(trailing:
            NavigationLink(destination: NewGoalView()){
                Text("Add a Goal")
        });
    }
}

struct NewGoalView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var goal: Goal = Goal(id: nil,
                                         title: "",
                                         description: "",
                                         status: "INCOMPLETE",
                                         dateCreated: Date().str(),
                                         dateCompleted: "",
                                         dateDue: "")
    var body: some View {
        VStack {
            Text("Title: " + self.goal.title)
            TextField("Enter a title: ", text: $goal.title).frame(height: 50, alignment: .center)
                .background(Color.gray)
                .border(Color.black)
                .padding(.bottom, 5)
            
            Text("Description: " + self.goal.description)
            TextField("Enter a description: ", text: $goal.description).frame(height: 50, alignment: .center)
                .background(Color.gray)
                .border(Color.black)
                .padding(.bottom, 5)
            
            Text("Due Date (" + dateFormat + "): " + self.goal.dateDue)
            TextField("Enter a due date: ", text: $goal.dateDue).frame(height: 50, alignment: .center)
                .background(Color.gray)
                .border(Color.black)
                .padding(.bottom, 5)
            
            Button("Create Goal", action: {
                if DBM.insert(self.goal) {
//                    self.presentationMode.wrappedValue.dismiss()
//                    self.presentationMode.
                } else {
                    self.goal.title = ""
                    self.goal.description = ""
                    self.goal.dateDue = ""
                    print("INSERTION ERROR")
                }
                print(DBM.all(Goal.self))
            })
        }.background(Color.green)
    }
}
