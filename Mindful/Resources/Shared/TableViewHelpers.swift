//
//  TableViewHelpers.swift
//  Mindful
//
//  Created by William Shelley on 6/29/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import UIKit

extension UITableView: CollectionSetup {
    func requiredSetup() throws {
        guard let controller = self.findViewController() else {
            throw ViewError.controllerError("View does not have a UIViewController ancestor")
        }
        
        guard let controllerDataSource = controller as? UITableViewDataSource else {
            throw ViewError.dataSourceError("Superview does not inherit from UITableViewDataSource")
        }
        
        guard let controllerDelegate = controller as? UITableViewDelegate else {
            throw ViewError.delegateError("Superview does not inherit from UITableViewDelegate")
        }
        self.delegate = controllerDelegate
        self.dataSource = controllerDataSource
    }
}
