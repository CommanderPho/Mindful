//
//  NewGoalView.swift
//  Mindful
//
//  Created by William Shelley on 7/3/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct NewGoalView: View {
    
    let date: Date
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var errorMessage: String = ""
    
    var body: some View {
        VStack {
            Text(self.errorMessage).foregroundColor(.red)
            Section {
            TextField("Enter a title: ", text: $title).frame(height: 50, alignment: .center)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Enter a description: ", text: $description).frame(height: 50, alignment: .center)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Section {
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
                    self.errorMessage = ""
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    // was unable to insert
                    self.errorMessage = "Cannot have any empty fields"
                }
            })
            }
            Spacer()
        }
    }
}

struct NewGoalView_Previews: PreviewProvider {
    static var previews: some View {
        NewGoalView(date: Date())
    }
}
