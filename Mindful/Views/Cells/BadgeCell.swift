//
//  BadgeCell.swift
//  Mindful
//
//  Created by William Shelley on 6/27/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import UIKit

class BadgeCell: UICollectionViewCell {
    var button: UIButton!
    var badge: Badge?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
        
    func commonInit() {
        button = UIButton(frame: bounds)
        let holdGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.onHold(_:)))
        button.addGestureRecognizer(holdGesture)

        addSubview(button)
        
        backgroundColor = .systemTeal
    }
    
    @objc func onHold(_ sender: UILongPressGestureRecognizer) {
        guard let badge = badge else { return }
        print(button.currentTitle ?? "empty")
        _ = try? dbQueue?.write({ db in try badge.delete(db) })
        button.setBackgroundImage(button.backgroundImage(for: .normal)?.withTintColor(.red), for: .normal)
    }
}
