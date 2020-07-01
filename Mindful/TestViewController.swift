//
//  ViewController.swift
//  Mindful
//
//  Created by William Shelley on 7/1/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import UIKit
import SwiftUI

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
    }
    
}

struct TView: UIViewControllerRepresentable {
    typealias Context = UIViewControllerRepresentableContext<TView>
    typealias UIViewControllerType = TestViewController
    
    func makeUIViewController(context: Context) -> TestViewController {
        return TestViewController()
    }
    
    func updateUIViewController(_ uiViewController: TestViewController, context: Context) {
        
    }
}

struct TestViewController_Previews: PreviewProvider {
    static var previews: some View {
        TView()
    }
}
