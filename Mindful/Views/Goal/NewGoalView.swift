//
//  NewGoalView.swift
//  Mindful
//
//  Created by William Shelley on 7/3/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct NewGoalView: View {
    
    let dateDue: Date
    var uuid: String = ""
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var errorMessage: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(self.errorMessage).foregroundColor(.red)
            
            TextField("Enter a title ...", text: $title).frame(height: 50, alignment: .center)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Enter a description ...", text: $description).frame(height: 50, alignment: .center)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Create Goal", action: {
                let zone = DBM.findByKey(Zone.self, keyName: "uuid", keyValue: self.uuid)
                let zoneId = ((zone != nil) && self.uuid.count > 0) ? zone!.id : nil
                let goal: Goal = Goal(
                    id: nil,
                    zoneId: zoneId,
                    title: self.title,
                    description: self.description,
                    dateCreated: Date().str(),
                    dateCompleted: "",
                    dateDue: self.dateDue.str())
                
                if DBM.insert(goal) {
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
