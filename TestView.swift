//
//  TestView.swift
//  Mindful
//
//  Created by William Shelley on 7/13/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI
//import ElegantCalendar

struct TestView: View {
    @State var someToggle: Bool = false
    var body: some View {
//
//        ElegantCalendarView(calendarManager: ElegantCalendarManager(configuration: CalendarConfiguration(startDate: Date(), endDate: Date().offsetBy(1, withUnit: .year))))
        
        VStack(spacing: 10){
            Spacer()
            VStack(alignment: .leading) {
                Spacer()
                Text("Welcome to Stream Tracker.")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                Spacer()
                Text("Promote your stream, get more followers and keep track of your followers on Twitch.")
                    .font(.system(size: 15))

                Text("Connect your channel to get started.")
                    .font(.system(size: 15))

                Spacer()
            }
            .foregroundColor(.black)
            .padding(5)
            .frame(width: SCREEN_WIDTH - 20, height: SCREEN_HEIGHT / 3)


            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                HStack(spacing: 10) {
                    Spacer()
                    Toggle("", isOn: self.$someToggle)
                        .frame(width: 50)
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Terms & Privacy Policy")
                            .font(.system(size: 17, weight: .bold, design: .rounded))
                            .foregroundColor(.black)
                        Text("Tick to agree")
                            .font(.system(size: 12, weight: .bold, design: .rounded))
                            .foregroundColor(.gray)
                    }
                    Spacer()

                    Image(systemName: "chevron.right")
                        .scaleEffect(1.3)
                        .foregroundColor(.gray)
                    Spacer()

                }

            }
            .frame(width: SCREEN_WIDTH - 20, height: SCREEN_HEIGHT / 10)




            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.purple)

                Text("Sign in with Twitch")
                    .font(.system(size: 17, weight: .bold, design: .rounded))

            }

            .frame(width: SCREEN_WIDTH - 20, height: SCREEN_HEIGHT / 14)


        }
        .padding(10)
        .preferredColorScheme(.dark)
        .background(Image("pebbles").scaledToFill())
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
