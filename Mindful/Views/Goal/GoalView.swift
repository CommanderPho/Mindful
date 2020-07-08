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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var goal: Goal
    @State var isComplete: Bool
    
    @State private var presentingCreateBadge: Bool = false
    @State private var errorMessage: String = ""
    @State private var badges: [Badge] = []
    @State private var presentingBadge: Bool = false
    
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
                                self.goal.dateCompleted = !self.goal.isComplete() ? Date().str() : ""
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
                
                HStack(alignment: .center, spacing: self.spacing) {
                    
                    Text("Badges")
                        .foregroundColor(.secondary)
                    
                    Image(systemName: "plus")
                        .onTapGesture { self.presentingCreateBadge.toggle() }
                        .foregroundColor(.accentColor)
                        .sheet(isPresented: self.$presentingCreateBadge, content: { NewBadgeView(goal: self.goal)})
                }
                
                BadgeGridView(badges: Badge.make2D(self.badges, columns: BADGES_COLLECTION_COLUMNS),
                              spacing: BADGES_CELL_SPACING)
                    .onReceive([self.badges].publisher.first(), perform: { value in
                        let retrievedBadges = DBM.hasMany(self.goal.badges)
                        if self.badges != retrievedBadges { self.badges = retrievedBadges }
                    })
                Spacer()
                
            }
        }
        .aspectRatio(contentMode: .fit)
        .foregroundColor(.blue)
        .navigationBarTitle(Text(self.goal.title), displayMode: .inline)
    }
    
}
