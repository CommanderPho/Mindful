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
    
    @State var selection: Int? = nil
    @State var uuid: String = UUID().uuidString
    @State var shouldDismiss: Bool = false
    
    @State private var selectedGoalIdx = -1
    private var goals: [Goal] {
        let allGoals: [Goal] = DBM.all(Goal.self)
        var uniqueGoals: [Goal] = []
        var uniqueTitles: Set<String> = []
        for goal in allGoals {
            if !uniqueTitles.contains(goal.title) {
                uniqueTitles.insert(goal.title)
                uniqueGoals.append(goal)
            }
        }
        
        
        return uniqueGoals
    }
    
    var body: some View {
        NavigationView {
            
            
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
                    
                    Picker(self.selectedGoalIdx >= 0 && self.selectedGoalIdx < self.goals.count ? self.goals[selectedGoalIdx].title : "Pick a Goal", selection: self.$selectedGoalIdx) {
                        ForEach(self.goals) { goal in
                            Text(goal.title)
                        }
                    }
                }
                
                Text(Date.minsBetween(start: startTime.timeStr(), end: endTime.timeStr()).str())
                
                NavigationLink(destination: NewGoalView(dateDue: self.date, uuid: self.uuid), tag: 1, selection: self.$selection){
                    
                    Button("Create Zone", action: {
                        
                        let zone: Zone = Zone(
                            id: nil,
                            uuid: self.uuid,
                            startTime: self.startTime.timeStr(),
                            endTime: self.endTime.timeStr(),
                            date: self.date.str(),
                            notes: self.notes,
                            minutesUsed: self.minutesUsed)
                        
                        if self.selectedGoalIdx < self.goals.count && self.selectedGoalIdx >= 0{
                
                            let goal = self.goals[self.selectedGoalIdx]
                            
                            if DBM.insert(goal) {
                                print("created goal")
                            }
                        }
                        
                        
                        if DBM.insert(zone) {
                            self.selection = 1
                            self.shouldDismiss = true
                            self.errorMessage = ""
                            
                            //                    print(zone.fetchSelf())
                            
                            //                    self.presentationMode.wrappedValue.dismiss()
                        } else {
                            // was unable to insert
                            self.errorMessage = "Could not save zone"
                        }
                    })
                }
                
            }
        }
        .onReceive([self.selection].publisher.first()) { value in
            if (value == nil && self.shouldDismiss) {
                self.presentationMode.wrappedValue.dismiss()
            }
        }.onReceive([self.selectedGoalIdx].publisher.first()) { value in
            print(value)
        }
    

    }
}
