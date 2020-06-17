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
//        printDefaults()
//        self.badges = []
//        print("something happening")
//        for i in 0...30 {
//
//            self.badges!.append(Badge(title: String(i), description: String(i), iconName: "badgeTest"))
//            // print(self.badges![i].toDict())
//        }
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
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
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
