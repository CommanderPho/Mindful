//
//  BadgeView.swift
//  Mindful
//
//  Created by William Shelley on 7/4/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct BadgeView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var badge: Badge
    @State var isComplete: Bool
    private let spacing: CGFloat = 10
    @State private var errorMessage: String = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: self.spacing) {
            VStack(alignment: .center, spacing: self.spacing) {
                Text(errorMessage)
                
                Button("Delete this badge") {
                    if DBM.delete(self.badge) { self.presentationMode.wrappedValue.dismiss() }
                }
                
                Spacer()
                
                Text(badge.title)
                    .font(.largeTitle)
                
                Spacer()
                
                Image(badge.imageName)
                    .scaleEffect(3)
                
                Spacer()
                
                Text(badge.description)
                
                Spacer()
            }
            
            Toggle("Completed?", isOn: self.$isComplete)
                .onReceive([self.isComplete].publisher.first(), perform: { value in
                    if self.badge.isEarned() != value {
                        self.badge.dateEarned = !self.badge.isEarned() ? Date().str() : "" 
                        if DBM.update(self.badge) { self.errorMessage = "" }
                        else { self.errorMessage = "Unable to save to DB" }
                    }
                })
                .toggleStyle(CheckboxToggleStyle(spacing: self.spacing))
            
            Text(badge.dateEarned)
            
            Spacer()
        }
    }
}
