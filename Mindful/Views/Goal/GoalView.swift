//
//  GoalView.swift
//  Mindful
//
//  Created by William Shelley on 6/30/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    let spacing: CGFloat
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center, spacing: self.spacing) {
            Spacer()
            configuration.label
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: CHECKBOX_DIM, height: CHECKBOX_DIM)
                .onTapGesture { configuration.isOn.toggle() }
            Spacer()
        }
    }
}

struct GoalView: View {
    @Binding var goal: Goal
    @State var isComplete: Bool
    
    @State private var presentingCreateBadge: Bool = false
    @State private var errorMessage: String = ""
    
    let spacing: CGFloat = 10
    
    var body: some View {
        
        return ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: self.spacing) {
                Text(self.errorMessage)
                    .foregroundColor(.red)
                
                Spacer()
                
                VStack(alignment: .center, spacing: self.spacing) {
                    Text(goal.description)
                    
                    Toggle("Completed?", isOn: self.$isComplete)
                        .onReceive([self.isComplete].publisher.first(), perform: { value in
                            if self.goal.isComplete() != value {
                                self.goal = Goal(id: self.goal.id,
                                                 title: self.goal.title,
                                                 description: self.goal.description,
                                                 dateCreated: self.goal.dateCreated,
                                                 dateCompleted: !self.goal.isComplete() ? Date().str() : "",
                                                 dateDue: self.goal.dateDue)
                                
                                if DBM.update(self.goal) { self.errorMessage = "" }
                                else { self.errorMessage = "Unable to save to DB" }
                            }
                        })
                        .toggleStyle(CheckboxToggleStyle(spacing: self.spacing))
                        
                    
                    Text("Created At: " + goal.dateCreated)
                    Text("Completed At: " + (goal.dateCompleted.isEmpty ? "---" : goal.dateCompleted))
                    Text("Due: " + goal.dateDue)
                }
                .foregroundColor(.secondary)
                
                Spacer()
                
                HStack(alignment: .center, spacing: 10) {
                    
                    Text("Badges")
                        .foregroundColor(.secondary)
                    
                    Image(systemName: "plus")
                        .onTapGesture { self.presentingCreateBadge.toggle() }
                        .foregroundColor(.accentColor)
                        .sheet(isPresented: self.$presentingCreateBadge, content: { NewBadgeView(goal: self.goal)})
                }
                
                BadgeGridView(badges: Badge.make2D(DBM.hasMany(goal.badges), columns: BADGES_COLLECTION_COLUMNS),
                              spacing: BADGES_CELL_SPACING)
                
                Spacer()
                
            }
        }
        .aspectRatio(contentMode: .fit)
        .foregroundColor(.blue)
        .navigationBarTitle(Text(self.goal.title), displayMode: .inline)
    }
    
}
