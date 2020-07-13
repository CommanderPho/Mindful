//
//  CollectionViewTest.swift
//  Mindful
//
//  Created by William Shelley on 7/10/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import SwiftUI
import UIKit

class VC: UICollectionViewController {
    let data = [Date(), Date().offsetBy(1, withUnit: .month), Date().offsetBy(2, withUnit: .month)]
    let cellId = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath)
        let child = UIHostingController(rootView: CalendarView(focusDate: data[indexPath.row], spacing: CALENDAR_CELL_SPACING));
        self.view.addSubview(child.view)
        cell.frame.size = collectionView.frame.size
        child.view.frame = cell.frame
        cell.contentView.addSubview(child.view)
        return cell
    }
}

struct NewView: UIViewControllerRepresentable {
    typealias UIViewControllerType = VC

    func makeUIViewController(context: Context) -> VC {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT / 3)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0,
                                           left: 0,
                                           bottom: SCREEN_HEIGHT,
                                           right: 0)
        return VC(collectionViewLayout: layout)
    }
    func updateUIViewController(_ uiViewController: VC, context: Context) {

    }
}

// for use in SwiftUI TabView
//            NewView()
//                .tabItem {
//                    Image(systemName: "calendar.circle")
//                    Text("Cal")
//            }
