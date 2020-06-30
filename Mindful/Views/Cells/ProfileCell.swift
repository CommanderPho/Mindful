//
//  ProfileCell.swift
//  Mindful
//
//  Created by William Shelley on 6/27/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        backgroundColor = .cyan
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
    }
}
