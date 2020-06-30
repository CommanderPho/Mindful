//
//  GoalCell.swift
//  Mindful
//
//  Created by William Shelley on 6/30/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
    }
}
