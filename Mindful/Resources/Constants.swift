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
let SHOW_ALL_BORDERS: Bool = false

let SCREEN_SIZE: CGRect = UIScreen.main.bounds
let SCREEN_WIDTH: CGFloat = SCREEN_SIZE.width
let SCREEN_HEIGHT: CGFloat = SCREEN_SIZE.height

let CALENDAR_ANIMATION_DURATION: Double = 0.25

let CALENDAR_CELL_DIM: CGFloat = SCREEN_WIDTH / CGFloat(Date.weekdays.count)
let CALENDAR_HEIGHT_MODIFIER: CGFloat = 0//SCREEN_HEIGHT / 20
let CALENDAR_CELL_HEIGHT: CGFloat = CALENDAR_CELL_DIM + CALENDAR_HEIGHT_MODIFIER
let CALENDAR_CELL_CORNER_RADIUS: CGFloat = 10
let CALENDAR_CELL_SPACING: CGFloat = 5
let CALENDAR_CELL_BORDER_SHOWING: Bool = SHOW_ALL_BORDERS || false
let CALENDAR_CELL_BORDER_LINE_WIDTH: CGFloat = 1

let WEEKHEADER_CELL_BORDER_SHOWING: Bool = SHOW_ALL_BORDERS || false

let BIG_TEXT_COLOR: Color = .blue

let BADGES_COLLECTION_COLUMNS: Int = 3
let BADGES_CELL_DIM: CGFloat = SCREEN_WIDTH / CGFloat(BADGES_COLLECTION_COLUMNS)
let BADGES_CELL_HEIGHT_MODIFIER: CGFloat = SCREEN_HEIGHT / 15
let BADGES_CELL_HEIGHT: CGFloat = BADGES_CELL_DIM + BADGES_CELL_HEIGHT_MODIFIER
let BADGES_CELL_SPACING: CGFloat = 15
let BADGES_CELL_CORNER_RADIUS: CGFloat = 10
let BADGES_CELL_BORDER_SHOWING: Bool = SHOW_ALL_BORDERS || true
let BADGES_CELL_BORDER_LINE_WIDTH: CGFloat = 1

let BADGE_INCOMPLETE_MESSAGE = "IN-PROGRESS"
let BADGE_COMPLETE_MESSAGE = "COMPLETE"
