//
//  ZonesListView.swift
//  Mindful
//
//  Created by William Shelley on 7/25/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct ZonesListView: View {
    @State private var showingNewZoneModal: Bool = false
    
    var date: Date
    @State private var zones: [Zone] = []
    var body: some View {
        VStack {
            Spacer()
            Text("Awareness Zones")
                .font(.largeTitle)
            
            List{
                ForEach(self.zones) { zone in
                    ZoneCell(zone: zone)
                }.onDelete(perform: { indexSet in
                    if DBM.delete(self.zones[indexSet.first!]) {
                        self.zones = self.date.zones()
                    }
                })
            }
            .navigationBarTitle(Text(self.date.formatted()), displayMode: .inline)
            .navigationBarItems(trailing:
                Image(systemName: "plus")
                    .onTapGesture { self.showingNewZoneModal.toggle() }
                    .foregroundColor(.accentColor)
                    .sheet(isPresented: self.$showingNewZoneModal, content: { NewZoneView(date: self.date) }))
                .onReceive([self.zones].publisher.first(), perform: { value in
                    if self.zones != self.date.zones() {
                        self.zones = self.date.zones()
                    }
                })
        }
    }
}
