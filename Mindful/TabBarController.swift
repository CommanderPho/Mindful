//
//  TabBarController.swift
//  Mindful
//
//  Created by William Shelley on 6/15/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import UIKit


class TabBarController: UITabBarController {
    
    var badgeSize: CGSize?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let numColumns = 3
        let dim = self.view.bounds.width / CGFloat(numColumns+1)
        let itemSize = CGSize(width: dim, height: dim)
        
        let badgesLayout = UICollectionViewFlowLayout()
        badgesLayout.itemSize = itemSize
        badgesLayout.minimumInteritemSpacing = 0
        badgesLayout.minimumLineSpacing = 0
        
        let calendarLayout = UICollectionViewFlowLayout()
        
        let timerVC = TimerVC()
        let badgesVC = BadgesVC(collectionViewLayout: badgesLayout)
        let calendarVC = CalendarVC(collectionViewLayout: calendarLayout)
        self.viewControllers = [timerVC, badgesVC, calendarVC].reversed()
    }
}
