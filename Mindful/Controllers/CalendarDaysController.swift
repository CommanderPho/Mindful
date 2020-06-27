//
//  CalendarDaysController.swift
//  Mindful
//
//  Created by William Shelley on 6/25/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import UIKit


class CalendarDaysController: UICollectionViewController {
    private let reuseIdentifier = "dayCell"
    private let numSections = 1
    private let numDaysInMonth = 30
    private var days: [Badge]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(DayCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.collectionView.backgroundColor = .cyan
        
        try? dbQueue?.read({ db in self.days = try Badge.fetchAll(db) })
    }

    // MARK: - Navigation

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numSections
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let days = days else { return numDaysInMonth }
        return days.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DayCell
//        cell.button.setBackgroundImage(UIImage(named: ), for: .normal)
        cell.button.setBackgroundImage(UIImage(named: days![indexPath.row].imageName), for: .normal)
        cell.button.setTitle(String(indexPath.row), for: .normal)
        return cell
    }

    // MARK: UICollectionViewDelegate
    
}
