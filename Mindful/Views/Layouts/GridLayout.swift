//
//  GridLayout.swift
//  Mindful
//
//  Created by William Shelley on 6/27/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import UIKit

class GridLayout: UICollectionViewFlowLayout {
    var numColumns: Int {
        get { return numItemColumns }
        set {
            numItemColumns = newValue
            commonInit()
        }
    }
    
    var spacing: CGFloat {
        get { return uniformItemSpace }
        set {
            horizontalSpacing = newValue
            verticalSpacing = newValue
            uniformItemSpace = newValue
            commonInit()
        }
    }
    
    var hSpacing: CGFloat {
        get { return horizontalSpacing }
        set {
            horizontalSpacing = newValue
        }
    }
    
    var vSpacing: CGFloat {
        get { return verticalSpacing }
        set {
            verticalSpacing = newValue
        }
    }
    
    private var numItemColumns: Int = 1
    private var horizontalSpacing: CGFloat = 1
    private var verticalSpacing: CGFloat = 1
    private var uniformItemSpace: CGFloat = 1

    private var screenWidth: CGFloat { return UIScreen.main.bounds.width }
    private var viewWidth: CGFloat {
        guard let view = collectionView else { return screenWidth }
        return view.bounds.width
    }
    
    private var itemWidth: CGFloat {
        let width = (viewWidth / CGFloat(numColumns+1)) - (hSpacing)
        return width > 0 ? width : 1
    }
    
    private var defaultComputeItemWidth: CGFloat = 0
    
    private var computedItemWidth: CGFloat {
        get { return defaultComputeItemWidth > 0 ? defaultComputeItemWidth : itemWidth }
        set { defaultComputeItemWidth = newValue }
    }
    
    private var itemHeight: CGFloat { return itemWidth }
    
    init(numColumns: Int, spacing: CGFloat){
        super.init()
        self.numColumns = numColumns
        self.spacing = spacing
    }
    
    override init() {
        super.init()
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        
        let extraSpace = viewWidth - (CGFloat(numColumns) * (itemWidth + hSpacing))
        let hInsetExtra = extraSpace > 0 ? (extraSpace / CGFloat(numColumns)) : 0
        let maxPercent = CGFloat(0.1) // 5 % of screen
        let currentPercent = hInsetExtra / viewWidth
        let maxInset = viewWidth * maxPercent
        let hInset = currentPercent > maxPercent ? maxInset : hSpacing + hInsetExtra
        
        self.minimumLineSpacing = vSpacing + hInsetExtra / 2
        self.minimumInteritemSpacing = hSpacing
        self.itemSize = CGSize(width: itemWidth, height: itemWidth)
        self.sectionInset = UIEdgeInsets(top: vSpacing,
                                         left: hInset,
                                         bottom: vSpacing,
                                         right: hInset)
    }
}
