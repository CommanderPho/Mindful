//
//  ZoneCell.swift
//  Mindful
//
//  Created by William Shelley on 7/10/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct ZoneCell: View {
    var zone: Zone
    let first = "08:00"
    let second = "23:00"
    @State private var startTime: Date = Date()
    @State private var endTime: Date = Date()
    var body: some View {
        VStack {
            
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
            }
            
            Text(Date.minsBetween(start: startTime.timeStr(), end: endTime.timeStr()).str())
        }
    }
}

struct ZoneCell_Previews: PreviewProvider {
    static var previews: some View {
        ZoneCell(zone: Zone(id: 0, startTime: "", endTime: "", date: "", notes: "", minutesUsed: 0))
    }
}
