//
//  Constants.swift
//  Mindful
//
//  Created by William Shelley on 6/30/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//


import UIKit
import SwiftUI

let SHOULD_SEED_DB: Bool = false
let SHOULD_ERASE_DB: Bool = false

let SCREEN_SIZE: CGRect = UIScreen.main.bounds
let SCREEN_WIDTH: CGFloat = SCREEN_SIZE.width
let SCREEN_HEIGHT: CGFloat = SCREEN_SIZE.height

let CALENDAR_ANIMATION_DURATION: Double = 0.25

let CALENDAR_CELL_DIM: CGFloat = SCREEN_WIDTH / CGFloat(Date.weekdays.count)
let CALENDAR_CELL_CORNER_RADIUS: CGFloat = 10
let CALENDAR_CELL_SPACING: CGFloat = 5

let BIG_TEXT_COLOR: Color = .blue

let BADGES_COLLECTION_COLUMNS: Int = 4
let BADGES_CELL_DIM: CGFloat = SCREEN_WIDTH / CGFloat(BADGES_COLLECTION_COLUMNS)
let BADGES_CELL_SPACING: CGFloat = 10
let BADGES_CELL_CORNER_RADIUS: CGFloat = 10

let BADGE_INCOMPLETE_MESSAGE = "IN-PROGRESS"
let BADGE_COMPLETE_MESSAGE = "COMPLETE"
