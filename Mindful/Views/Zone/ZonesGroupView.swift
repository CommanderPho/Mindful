//
//  ZonesGroupView.swift
//  Mindful
//
//  Created by William Shelley on 7/13/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct ZonesGroupView: View {
    @State private var showingNewZoneModal: Bool = false
    
    var date: Date
    @State private var zones: [Zone] = []
    
    private let hrs: [Int] = Array(0...24)
    var body: some View {
        VStack {
            
            Text("Zones")
                .font(.largeTitle)
            Text(zones.count.str())
            
            ScrollView {
                ZStack(alignment: .top) {
                    VStack {
                        ForEach(self.hrs, id: \.self) { hr in
                            HStack(alignment: .center, spacing: 0) {
                                Text(hr.str())
                                VStack(alignment: .center, spacing: 0) {
                                    Divider()
                                }
                        }
                        }.frame(height: 50)
                    }
                    
                    Section {
                        ForEach(self.zones, id: \.self) { zone in
                            NavigationLink(destination: ZoneView(zone: zone)){
                                ZoneCell(zone: zone)
                            }
                        }
                    }
                    
                    }
                
                .navigationBarItems(trailing:
                    Image(systemName: "plus")
                        .onTapGesture { self.showingNewZoneModal.toggle() }
                        .foregroundColor(.accentColor)
                        .sheet(isPresented: self.$showingNewZoneModal, content: { NewZoneView(date: self.date)}))
                    .onReceive([self.zones].publisher.first(), perform: { value in
                        if self.zones != self.date.zones() {
                            self.zones = self.date.zones()
                        }
                    })
            }
        }
    }
}
