//
//  AllBadgesView.swift
//  Mindful
//
//  Created by William Shelley on 7/9/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct AllBadgesView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var badges: [[Badge]] = []
    
    var body: some View {
        return ScrollView(showsIndicators: false){
            BadgeGridView(badges: self.$badges, spacing: BADGES_CELL_SPACING)
                BadgeGridView(badges: self.$badges, spacing: BADGES_CELL_SPACING)
                    .onReceive([self.badges].publisher.first(), perform: { value in
                        let allBadges: [Badge] = DBM.all(Badge.self)
                        let retrievedBadges = Badge.make2D(allBadges, columns: BADGES_COLLECTION_COLUMNS)
                        if self.badges != retrievedBadges {
                            self.badges = retrievedBadges }
                    })
                .frame(width: SCREEN_WIDTH, alignment: .topLeading)
        }
    }
}

struct AllBadgesView_Previews: PreviewProvider {
    static var previews: some View {
        AllBadgesView()
    }
}
