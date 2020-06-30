//
//  DayCell.swift
//  Mindful
//
//  Created by William Shelley on 6/25/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import UIKit

class DayCell: UICollectionViewCell {
    var button: UIButton!
    var day: Day?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
        
    private func commonInit() {
        button = UIButton(frame: bounds)
        button.addTarget(self, action: #selector(onTap), for: .touchUpInside)

        addSubview(button)
        
        backgroundColor = .systemTeal
    }
    
    @objc func onTap() {
        guard let day = day else { return }
        
        guard let vc = self.findViewController() else { return }

        let dayVC = DayController()
        dayVC.day = self.day
        dayVC.view.backgroundColor = .systemPink
        
        vc.present(dayVC, animated: true)
        
        try? dbQueue?.write({ db in
            let goal = try Goal.fetchAll(db).last!
            let badge = Badge(id: nil, goalId: goal.id, dayId: day.id,
                              description: "badge " + String(button.currentTitle ?? "empty"),
                              imageName: "badge")
            try badge.insert(db)
            
            
//            let new_goal = Goal(id: nil, userId: 1, description: "this is a new goal", status: "IN-PROGRESS",
//                                createdDayId: day.id, completedDayId: day.id, deadlineDayId: day.id)
//            
//            try new_goal.insert(db)
        })
    }
}
