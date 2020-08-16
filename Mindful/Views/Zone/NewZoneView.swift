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
    @State private var startTime: Date = Date().time().toDateTime()
    @State private var endTime: Date = Date().time(offsetByMinutes: 30).toDateTime()
    @State private var notes: String = ""
    @State private var errorMessage: String = ""
    private var minutesUsed: Int { return Date.minsBetween(start: self.startTime.timeStr(), end: self.endTime.timeStr())}
    
//    @State var selection: Int? = nil
    @State var uuid: String = UUID().uuidString
//    @State var shouldDismiss: Bool = false
    @State var selectedGoals: [Goal] = []
    
    @State var goals: [Goal] = []
    var fetchedGoals: [Goal] {
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
                Text(self.date.formatted())
                    .font(.largeTitle)
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
                    
                    Section {
                        MultipleSelectionList(items: self.$goals, selections: self.$selectedGoals)
                    }
                    
                    
                }
                .onAppear() {
                    self.goals = self.fetchedGoals
                }
                
//                Text(Date.minsBetween(start: startTime.timeStr(), end: endTime.timeStr()).str())
                
                NavigationLink(destination: NewGoalView(dateDue: self.date, uuid: self.uuid)){
                    Text("New Goal")
                }
                Spacer()
                
                Button("Create Zone", action: {
                    
                    let zone: Zone = Zone(
                        id: nil,
                        uuid: self.uuid,
                        startTime: self.startTime.timeStr(),
                        endTime: self.endTime.timeStr(),
                        date: self.date.str(),
                        notes: self.notes,
                        minutesUsed: self.minutesUsed)
                    
                    if DBM.insert(zone) {
                        
                        self.errorMessage = ""
                        
                        var i = 0
                        let fetchedZone = DBM.findByKey(Zone.self, keyName: "uuid", keyValue: self.uuid)
                        
                        while i < self.selectedGoals.count {
                            self.selectedGoals[i].zoneId = fetchedZone?.id
                            self.selectedGoals[i].id = nil
                            
                            _ = DBM.insert(self.selectedGoals[i])
                            i+=1
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        // was unable to insert
                        self.errorMessage = "Could not save zone"
                    }
                })
                
                
            }
        }
        
    }
}

struct MultipleSelectionList: View {
    //    @State var items: [String] = ["Apples", "Oranges", "Bananas", "Pears", "Mangos", "Grapefruit"]
    @Binding var items: [Goal]
    @Binding var selections: [Goal]
    
    var body: some View {
        List {
            ForEach(self.items, id: \.self) { goal in
                MultipleSelectionRow(title: goal.title, isSelected: self.selections.contains(goal)) {
                    if self.selections.contains(goal) {
                        self.selections.removeAll(where: { $0 == goal })
                    }
                    else {
                        
                        self.selections.append(goal)
                        self.selections[self.selections.count - 1].dateCompleted = ""
                    }
                }
            }
        }
    }
}


struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}
