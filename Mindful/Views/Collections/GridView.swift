//
//  GridView.swift
//  Mindful
//
//  Created by William Shelley on 6/30/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct GridView<T: ApplicationRecord, Content>: View where Content: View {
    
    
    let numCols: Int
    var spacing: CGFloat = 5
    let data: [T]
    
    let content: (_ item: T, _ width: CGFloat, _ height: CGFloat) -> Content
    
    private var grid: [[T?]] { return gridify(numCols: numCols, data: data)}
    private var itemWidth: CGFloat { return (screenWidth / CGFloat(numCols)) - self.spacing }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: self.spacing) {
                ForEach(grid, id: \.self){ row in
                    HStack(alignment: .center, spacing: self.spacing) {
                        ForEach(row, id: \.self){ col in
                            self.content(col!, self.itemWidth, self.itemWidth)
                        }
                    }
                }
            }
        }
    }
}

private func gridify<T>(numCols: Int, data: [T]) -> [[T?]] {
    
    var grid: [[T?]] = [[]]
    
    var idx = 0
    var row = 0
    
    while idx < data.count {
        var col = 0
        
        while col < numCols && idx < data.count{
            
            if grid[grid.count-1].count >= numCols {
                grid.append([])
            }
            
            grid[row].append(data[idx])
            
            col+=1
            idx+=1
        }
        row+=1
    }
    
    return grid
}
