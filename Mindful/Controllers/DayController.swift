//
//  DayView.swift
//  Mindful
//
//  Created by William Shelley on 6/29/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import UIKit

class DayController: UIViewController {
    private let numSections = 5
    var day: Day?
    var goals = [Goal]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let safeArea = self.view.safeAreaLayoutGuide
        
        guard let day = day else { return }
        try? dbQueue?.read({ db in self.goals = try day.goalsCreated.fetchAll(db) })
        view.backgroundColor = .systemPink
        
        let table = GoalsTableView(frame: safeArea.layoutFrame)
        view.addSubview(table)
        
        table.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            table.heightAnchor.constraint(equalTo: table.heightAnchor),
        ])
    }
}

extension DayController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return numSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
}

extension DayController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GoalCell.reuseIdentifier, for: indexPath) as! GoalCell

        cell.backgroundColor = .systemBlue
        cell.leftLabel.text = "Left Text"
        cell.rightLabel.text = "Right Text"
        return cell
    }
}
