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
            NavigationLink(destination: NewGoalView(date: self.date)){
                Text("Add a Goal")
        });
    }
}

struct NewGoalView: View {
    let date: Date
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var title: String = ""
    @State private var description: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter a title: ", text: $title).frame(height: 50, alignment: .center)
                .background(Color.gray)
                .border(Color.black)
                .padding(.bottom, 5)
            
            TextField("Enter a description: ", text: $description).frame(height: 50, alignment: .center)
                .background(Color.gray)
                .border(Color.black)
                .padding(.bottom, 5)
            
            Button("Create Goal", action: {
                let goal: Goal = Goal(
                    id: nil,
                    title: self.title,
                    description: self.description,
                    status: "IN-PROGRESS",
                    dateCreated: Date().str(),
                    dateCompleted: "",
                    dateDue: self.date.str())
                
                if DBM.insert(goal) {
                    self.presentationMode.wrappedValue.dismiss()
//                    self.presentationMode.
                } else {
                    self.title = "Non-empty Title"
                    self.description = "Non-empty Title"
                    print("INSERTION ERROR")
                }
//                print(DBM.all(Goal.self))
            })
        }.background(Color.green)
    }
}
