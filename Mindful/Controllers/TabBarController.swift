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
        
        let layout = UICollectionViewFlowLayout()

        self.viewControllers = [
            CalendarDaysController(collectionViewLayout: layout),
            BadgesController(collectionViewLayout: layout)
        ]
    }
}
