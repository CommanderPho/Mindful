//
//  ProfileController.swift
//  Mindful
//
//  Created by William Shelley on 6/27/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import UIKit

private let reuseIdentifier = "profileCell"

class ProfileController: UIViewController  {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 0)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let table = UITableView(frame: view.bounds)
        table.register(ProfileCell.self, forCellReuseIdentifier: reuseIdentifier)
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.sizeToFit()
        self.view.addSubview(table)
        
        let tabBarHeight = tabBarController?.tabBar.bounds.height
        
        
        NSLayoutConstraint.activate([
            table.widthAnchor.constraint(equalToConstant: view.bounds.width),
            table.heightAnchor.constraint(equalToConstant: table.bounds.height),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -tabBarHeight!),
            table.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension ProfileController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}

extension ProfileController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProfileCell
        
        return cell
    }
}
