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
        VStack(alignment: .center) {
            Text("Profile")
                .frame(height: screenHeight / 2)
            Divider()
            NavigationView {
                VStack {
                    ProfileRow(left: "Points", middle: String(points))
                    ProfileRow(left: "Badges")
                    ProfileRow(left: "Goals")
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
