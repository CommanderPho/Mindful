//
//  ProfileController.swift
//  Mindful
//
//  Created by William Shelley on 6/27/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import UIKit

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
        
        let table = ProfileTableView(frame: view.bounds)
        let profilePic = ProfilePictureView(frame: view.bounds)
        
        let vStack = UIStackView(frame: view.bounds)
        vStack.axis = .vertical
        
        
        try? table.requiredSetup()
        self.view.addSubview(vStack)
        vStack.addArrangedSubview(profilePic)
        vStack.addArrangedSubview(table)
        
        let safeArea = self.view.safeAreaLayoutGuide
        vStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vStack.heightAnchor.constraint(equalTo: safeArea.heightAnchor),
            vStack.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
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
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableView.reuseIdentifier, for: indexPath) as! ProfileCell
        
        return cell
    }
}
