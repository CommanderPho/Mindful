//
//  CalendarDaysController.swift
//  Mindful
//
//  Created by William Shelley on 6/25/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import UIKit

private let reuseIdentifier = "dayCell"

class CalendarDaysController: UICollectionViewController {
    private var days = [Day]()
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        self.tabBarItem = UITabBarItem(title: "Calendar", image: UIImage(systemName: "rosette"), tag: 0)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.register(DayCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.collectionView.backgroundColor = .cyan
        
        try? dbQueue?.read({ db in self.days = try Day.fetchAll(db) })
    }

    // MARK: - Navigation

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DayCell
//        cell.button.setBackgroundImage(UIImage(named: ), for: .normal)
//        cell.button.setBackgroundImage(UIImage(named: days![indexPath.row].imageName), for: .normal)
        cell.button.setTitle(String(indexPath.row), for: .normal)
        return cell
    }

    // MARK: UICollectionViewDelegate
    
}
