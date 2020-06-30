//
//  TableRow.swift
//  Mindful
//
//  Created by William Shelley on 6/30/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct Cell<T: ApplicationRecord>: View {
    let data: T
    var stringData: [String] {
        var result: [String] = []
        let mirrored = Mirror(reflecting: data)
        for attr in mirrored.children {
            if type(of: attr.value) == String.self {
                result.append(attr.value as! String)
            }
        }
        return result
    }
    var body: some View {
        HStack {
//            Text(stringData.joined(separator: "---"))
            Text(String(describing: data))
        }
        .border(Color.black)
        
    }
}
