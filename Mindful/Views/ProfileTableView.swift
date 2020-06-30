//
//  ProfileTableView.swift
//  Mindful
//
//  Created by William Shelley on 6/29/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import UIKit


class ProfileTableView: UITableView {
    static let reuseIdentifier = "profileCell"
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        guard let _ = superview else { return }
        
        register(ProfileCell.self, forCellReuseIdentifier: ProfileTableView.reuseIdentifier)
        
        _ = try! self.requiredSetup()
        
        backgroundColor = .black
        
        sizeToFit()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: superview!.bounds.width),
            heightAnchor.constraint(equalToConstant: self.bounds.height),
            centerXAnchor.constraint(equalTo: superview!.centerXAnchor),
            bottomAnchor.constraint(equalTo: superview!.bottomAnchor)
        ])
    }
}
