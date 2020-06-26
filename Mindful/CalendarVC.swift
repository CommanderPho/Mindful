//
//  CalendarVC.swift
//  Mindful
//
//  Created by William Shelley on 6/16/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CalendarVC: UICollectionViewController {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        self.tabBarItem = UITabBarItem(title: "Calendar", image: UIImage(systemName:"calendar"), tag: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let currentStoreSize = findEarnedBadgesByKey().count
        let badge = Badge(title: String(currentStoreSize), description: String(currentStoreSize), iconName: "badgeTest")
        badge.store()
        printDefaults()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
        
        self.collectionView.backgroundColor = .white
        let bounds = self.collectionView.bounds
        let title = UILabel(frame: bounds.insetBy(dx: bounds.width * 0.02, dy: bounds.height * 0.45).offsetBy(dx: 0, dy: -bounds.height * 0.38))
        title.text = "Calendar"
        title.font = UIFont.systemFont(ofSize: 35)
        title.backgroundColor = .lightGray
        title.textAlignment = .center
        self.view.addSubview(title)
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        // Configure the cell
        
        return cell
    }
    
}
