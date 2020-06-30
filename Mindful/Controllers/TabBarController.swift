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
        
        let profileController = ProfileController()
        let daysController = DaysController(collectionViewLayout: calendarLayout)
        let badgesController = BadgesController(collectionViewLayout: badgesLayout)
        let timerController = TimerController()
        
        self.viewControllers = [
            profileController,
            daysController,
            badgesController,
            timerController,
        ]
        
        let color = UIColor.systemBlue
        
        let action: (_ view: UIView) -> () = { view in
            if view.backgroundColor == UIColor.black {
                view.backgroundColor = color
            }
        }
        
        
        for vc in self.viewControllers! {
            vc.view.performOnSubviews(action: action)
            vc.view.backgroundColor = color
        }
    }
}
