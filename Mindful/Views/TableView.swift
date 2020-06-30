//
//  SwiftUIView.swift
//  Mindful
//
//  Created by William Shelley on 6/30/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct TableView<T: ApplicationRecord>: View {
    // State so that it automatically updates interface when data changes
    @State var data: [T]
    
    var body: some View {
        NavigationView {
            List(data) { datum in
                Cell(data: datum)
            }
        }
    }
}
