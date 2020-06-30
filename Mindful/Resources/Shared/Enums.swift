//
//  Enums.swift
//  Mindful
//
//  Created by William Shelley on 6/29/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import Foundation

enum ViewError: Error {
    case delegateError(_ msg: String), dataSourceError(_ msg: String), controllerError(_ msg: String)
    case presentError(_ msg: String)
        
}
