//
//  BadgesController.swift
//  Mindful
//
//  Created by William Shelley on 6/27/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import UIKit

private let reuseIdentifier = "badgeCell"

class BadgesController: UICollectionViewController {
    var badges = [Badge]()
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        self.tabBarItem = UITabBarItem(title: "Badges", image: UIImage(systemName: "rosette"), tag: 0)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(BadgeCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        self.collectionView.backgroundColor = .cyan
        
        try? dbQueue?.read({ db in self.badges = try Badge.fetchAll(db) })
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return badges.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BadgeCell
    
        cell.button.setBackgroundImage(UIImage(named: badges[indexPath.row].imageName), for: .normal)
        cell.button.setTitle(String(indexPath.row), for: .normal)
        
        return cell
    }

    // MARK: UICollectionViewDelegate
}
