//
//  GoalCell.swift
//  Mindful
//
//  Created by William Shelley on 6/30/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {
    
    static let reuseIdentifier = "GoalCell"
    
//    @IBOutlet weak var leftLabel: UILabel!
//
//    @IBOutlet weak var rightLabel: UILabel!
    
    @IBOutlet weak var leftLabel: UILabel!
    
    @IBOutlet weak var rightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
    }
}
