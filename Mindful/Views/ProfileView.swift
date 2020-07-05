//
//  ProfileView.swift
//  Mindful
//
//  Created by William Shelley on 6/30/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    
    var points: Int = 623
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center) {
                Text("Profile")
                    .frame(height: SCREEN_HEIGHT / 2)
                Divider()
                ProfileChartView()
                Divider()
                
                VStack {
                    ProfileRowView(left: "Points")
                    ProfileRowView(left: "Badges")
                    ProfileRowView(left: "Goals")
                }
                Spacer()
                
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
