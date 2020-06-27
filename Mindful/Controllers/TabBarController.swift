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
        
        let calendarLayout = UICollectionViewFlowLayout()
        let numColumns = 4
        let itemWidth = view.bounds.width / CGFloat(numColumns + 1)
        let itemHeight = itemWidth
        let itemSize = CGSize(width: itemWidth, height: itemHeight)
        let spacing = 3
        let spacingAsFloat = CGFloat(spacing)
        let inset = itemWidth / 4
        calendarLayout.minimumInteritemSpacing = spacingAsFloat
        calendarLayout.minimumLineSpacing = spacingAsFloat
        calendarLayout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        calendarLayout.itemSize = itemSize
        
        let badgesLayout = UICollectionViewFlowLayout()

        self.viewControllers = [
            CalendarDaysController(collectionViewLayout: calendarLayout),
            BadgesController(collectionViewLayout: badgesLayout),
            ProfileController()
        ]
    }
}
