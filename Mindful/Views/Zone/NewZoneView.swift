//
//  NewZoneView.swift
//  Mindful
//
//  Created by William Shelley on 7/13/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct NewZoneView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var date: Date
    @State private var startTime: Date = "00:00".toDateTime()
    @State private var endTime: Date = "12:00".toDateTime()
    @State private var notes: String = ""
    @State private var errorMessage: String = ""
    private var minutesUsed: Int { return Date.minsBetween(start: self.startTime.timeStr(), end: self.endTime.timeStr())}
    var body: some View {
        VStack {
            Text(self.errorMessage)
            
            Text(self.date.formatted())
                .font(.largeTitle)
            
            Text("Create Awareness Zone")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .frame(width: SCREEN_WIDTH / 2, height: SCREEN_WIDTH / 2, alignment: .center)
                .foregroundColor(.blue)
            
            
            Form {
                Section{
                    HStack{
                        Text("Start")
                        DatePicker("", selection: self.$startTime, displayedComponents: .hourAndMinute)
                    }
                }
                Section{
                    HStack {
                        Text("End")
                        DatePicker("", selection: self.$endTime, displayedComponents: .hourAndMinute)
                    }
                }
                Section{
                    TextField("Notes", text: self.$notes)
                }
            }
            
            Text(Date.minsBetween(start: startTime.timeStr(), end: endTime.timeStr()).str())
            
            Button("Create Zone", action: {
                let zone: Zone = Zone(
                    id: nil,
                    startTime: self.startTime.timeStr(),
                    endTime: self.endTime.timeStr(),
                    date: self.date.str(),
                    notes: self.notes,
                    minutesUsed: self.minutesUsed)
                
                if DBM.insert(zone) {
                    self.errorMessage = ""
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    // was unable to insert
                    self.errorMessage = "Could not save zone"
                }
            })
        }
    }
}
