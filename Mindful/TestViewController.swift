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

class CalendarViewController<T: ApplicationRecord>: UICollectionViewController {
    init(data: [T], collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

struct CalendarView2<T: ApplicationRecord>: UIViewControllerRepresentable {
    typealias Context = UIViewControllerRepresentableContext<CalendarView2<T>>
    typealias ReturnContext = CalendarViewController<T>
    typealias UIViewControllerType = CalendarViewController<T>
    
    let data: [T]
    
    private let layout: UICollectionViewLayout = UICollectionViewFlowLayout()
    
    func makeUIViewController(context: Context) -> ReturnContext {
        return CalendarViewController<T>(data: self.data, collectionViewLayout: self.layout)
    }
    
    func updateUIViewController(_ uiViewController: ReturnContext, context: Context) {
        
    }
}

//struct TView: UIViewControllerRepresentable {
//    typealias Context = UIViewControllerRepresentableContext<TView>
//    typealias UIViewControllerType = TestViewController
//
//    func makeUIViewController(context: Context) -> TestViewController {
//        return TestViewController()
//    }
//
//    func updateUIViewController(_ uiViewController: TestViewController, context: Context) {
//
//    }
//}

//struct TestViewController_Previews: PreviewProvider {
//    static var previews: some View {
//        TView()
//    }
//}
