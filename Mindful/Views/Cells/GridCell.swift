//
//  GridCell.swift
//  Mindful
//
//  Created by William Shelley on 6/30/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

protocol GridCell {
    associatedtype AR // Application Record
    
    var item: AR { get set }
    var width: CGFloat { get set }
    var height: CGFloat { get set }
}
