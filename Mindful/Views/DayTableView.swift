//
//  DayTableView.swift
//  Mindful
//
//  Created by William Shelley on 6/29/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import UIKit

class DayTableView: UITableView {
    static let reuseIdentifier = "dayTableCell"
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        guard let _ = superview else { return }
        
        register(GoalCell.self, forCellReuseIdentifier: DayTableView.reuseIdentifier)
        
        _ = try! self.requiredSetup()
        
        backgroundColor = .black
        
        sizeToFit()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: superview!.bounds.width),
            heightAnchor.constraint(equalToConstant: self.bounds.height),
            centerXAnchor.constraint(equalTo: superview!.centerXAnchor),
            topAnchor.constraint(equalTo: superview!.topAnchor)
        ])
    }
}
