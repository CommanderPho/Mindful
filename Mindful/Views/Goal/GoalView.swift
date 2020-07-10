//
//  GoalView.swift
//  Mindful
//
//  Created by William Shelley on 6/30/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

class Obj: ObservableObject {
    var title: String = "Str"
}


struct GoalView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var goal: Goal
    @State var isComplete: Bool
    
    @State private var presentingCreateBadge: Bool = false
    @State private var errorMessage: String = ""
    @State private var badges: [[Badge]] = []
    
    let spacing: CGFloat = 10
    
    var body: some View {
        return ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: self.spacing) {
                Text(self.errorMessage)
                    .foregroundColor(.red)
                
                Spacer()
                
                VStack(alignment: .center, spacing: self.spacing) {
                    Text(self.goal.description)
                    
                    Toggle("Completed?", isOn: self.$isComplete)
                        .onReceive([self.isComplete].publisher.first(), perform: { value in
                            if self.goal.isComplete() != value {
                                self.goal.dateCompleted = !self.goal.isComplete() ? Date().str() : ""
                                if DBM.update(self.goal) { self.errorMessage = "" }
                                else { self.errorMessage = "Unable to save to DB" }
                            }
                        })
                        .toggleStyle(CheckboxToggleStyle(spacing: self.spacing))
                        
                    
                    Text("Created At: " + self.goal.dateCreated)
                    Text("Completed At: " + (self.goal.dateCompleted.isEmpty ? "---" : self.goal.dateCompleted))
                    Text("Due: " + self.goal.dateDue)
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
                
                BadgeGridView(badges: self.$badges, spacing: BADGES_CELL_SPACING)
                    .onReceive([self.badges].publisher.first(), perform: { value in
                        let retrievedBadges = Badge.make2D(DBM.hasMany(self.goal.badges), columns: BADGES_COLLECTION_COLUMNS)
                        if self.badges != retrievedBadges {
                            self.badges = retrievedBadges }
                    })
                Spacer()
            }
        }
        .aspectRatio(contentMode: .fit)
        .foregroundColor(.blue)
        .navigationBarTitle(Text(self.goal.title), displayMode: .inline)
    }
    
}
