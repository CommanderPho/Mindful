//
//  Styles.swift
//  Mindful
//
//  Created by William Shelley on 7/8/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    let spacing: CGFloat
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center, spacing: self.spacing) {
            Spacer()
            configuration.label
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: CHECKBOX_DIM, height: CHECKBOX_DIM)
                .onTapGesture { configuration.isOn.toggle() }
            Spacer()
        }
    }
}
