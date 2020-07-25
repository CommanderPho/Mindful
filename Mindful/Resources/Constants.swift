//
//  Constants.swift
//  Mindful
//
//  Created by William Shelley on 6/30/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//


import UIKit
import SwiftUI

private var AVAILABLE_14: Bool {
    if #available(iOS 14, *) { return true }
    else { return false }
}

private let USE_14: Bool = AVAILABLE_14

#if USE_14
    typealias VStack = LazyVStack
    typealias HStack = LazyHStack
#else
#endif

let SHOULD_SEED_DB: Bool = true
let SHOULD_ERASE_DB: Bool = true
let SHOW_ALL_BORDERS: Bool = false

let SCREEN_SIZE: CGRect = UIScreen.main.bounds
let SCREEN_WIDTH: CGFloat = SCREEN_SIZE.width
let SCREEN_HEIGHT: CGFloat = SCREEN_SIZE.height


let DATE_FORMAT = "yyyy-MM-dd"
let DATE_FORMAT_LENGTH = DATE_FORMAT.count
let TIME_FORMAT = "HH:mm"
let TIME_FORMAT_LENGTH = TIME_FORMAT.count


let CALENDAR_ANIMATION_DURATION: Double = 0.25

let CALENDAR_CELL_DIM: CGFloat = SCREEN_WIDTH / CGFloat(Date.weekdays.count)
let CALENDAR_HEIGHT_MODIFIER: CGFloat = 0//SCREEN_HEIGHT / 20
let CALENDAR_CELL_HEIGHT: CGFloat = CALENDAR_CELL_DIM + CALENDAR_HEIGHT_MODIFIER
let CALENDAR_CELL_CORNER_RADIUS: CGFloat = 10
let CALENDAR_CELL_SPACING: CGFloat = 5
let CALENDAR_CELL_BORDER_SHOWING: Bool = SHOW_ALL_BORDERS
let CALENDAR_CELL_BORDER_LINE_WIDTH: CGFloat = 1

let WEEKHEADER_CELL_BORDER_SHOWING: Bool = SHOW_ALL_BORDERS

let BIG_TEXT_COLOR: Color = .blue

let BADGES_COLLECTION_COLUMNS: Int = 3
let BADGES_CELL_DIM: CGFloat = SCREEN_WIDTH / CGFloat(BADGES_COLLECTION_COLUMNS)
let BADGES_CELL_HEIGHT_MODIFIER: CGFloat = SCREEN_HEIGHT / 15
let BADGES_CELL_HEIGHT: CGFloat = BADGES_CELL_DIM + BADGES_CELL_HEIGHT_MODIFIER
let BADGES_CELL_SPACING: CGFloat = 15
let BADGES_CELL_CORNER_RADIUS: CGFloat = 10
let BADGES_CELL_BORDER_SHOWING: Bool = SHOW_ALL_BORDERS
let BADGES_CELL_BORDER_LINE_WIDTH: CGFloat = 1

let INCOMPLETE_MESSAGE = "IN-PROGRESS"
let COMPLETE_MESSAGE = "COMPLETE"

let CHECKBOX_DIM: CGFloat = SCREEN_WIDTH / 20
