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
    
    private let hrs: [Int] = Array(1...24)
    private let hourHeight: CGFloat = 60
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                ZStack {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(self.hrs, id: \.self) { hr in
                            
                            VStack (alignment: .leading, spacing: 0){
                                Divider()
                                Text(hr.toHourStr())

                                Spacer()
                            }
                            .frame(height: self.hourHeight)
                            .border(Color.black)
                        }
                    }
                    
                    ZStack {
                        ForEach(self.zones, id: \.self) { zone in
                            ZoneCell(zone: zone)
                        }
                    }
                }
                
            }
        }
        .navigationBarTitle(date.formatted())
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
