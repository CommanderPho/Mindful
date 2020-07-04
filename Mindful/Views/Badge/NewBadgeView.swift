//
//  CreateBadgeView.swift
//  Mindful
//
//  Created by William Shelley on 7/4/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct NewBadgeView: View {
    let goal: Goal
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var errorMessage: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(self.errorMessage).foregroundColor(.red)
            
            TextField("Enter a title ...", text: self.$title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Enter a description ...", text: self.$description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Spacer()
            
            Button("Create Badge", action: {
                let badge: Badge = Badge(
                    id: nil,
                    goalId: self.goal.id,
                    title: self.title,
                    description: self.description,
                    imageName: "badge",
                    dateEarned: "")
                    
                if DBM.insert(badge) {
                    self.errorMessage = ""
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    // was unable to insert
                    self.errorMessage = "Cannot have any empty fields"
                }
            })
            
            Spacer()
        }
    }
}
