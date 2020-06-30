//
//  HelperMethods.swift
//  Mindful
//
//  Created by William Shelley on 6/29/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import UIKit

extension UIView {
    
    // recursively performs action on view and all its subviews ...
    func performOnSubviews(action: (UIView) -> Void){
        action(self)
        for subview in self.subviews {
            subview.performOnSubviews(action: action)
        }
    }
    
    // recursively looks for nearest viewcontroller responsible for this view
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}
