//
//  CalendVC.swift
//  Mindful
//
//  Created by William Shelley on 6/15/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class BadgesVC: UICollectionViewController {
    
    var badges = [Badge]()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        self.tabBarItem = UITabBarItem(title: "Badges", image: UIImage(systemName:"rosette"), tag: 0)
        clearDefaults()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let badgesEarned = findEarnedBadgesByKey()
        self.badges = []
        let maxItems = 30
        var idx = badgesEarned.count
        for (_, value) in badgesEarned {
            self.badges.append(Badge.loadFromDict(options: value as? [String:Any] ?? [String:Any]()))
        }
        while idx < maxItems {
            self.badges.append(Badge(title: "?", description: "?", iconName: "badgeTestUndiscovered"))
            idx+=1
        }
        self.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // clearDefaults()
        
        self.collectionView.backgroundColor = .white
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.badges.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let badge = self.badges[indexPath.row]
        cell.backgroundView = UIImageView(image: UIImage(named: badge.iconName))
        if badge.isUndiscovered(){
            cell.backgroundView?.tintColor = .darkGray
        }
        return cell
    }
    
}
