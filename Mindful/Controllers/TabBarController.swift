//
//  TabBarController.swift
//  Mindful
//
//  Created by William Shelley on 6/27/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let calendarLayout = GridLayout(numColumns: 5, spacing: 5)
        let badgesLayout = GridLayout(numColumns: 4, spacing: 5)
        
        self.viewControllers = [
            CalendarDaysController(collectionViewLayout: calendarLayout),
            BadgesController(collectionViewLayout: badgesLayout),
            TimerController(),
            ProfileController()
        ]
    }
}
