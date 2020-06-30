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
        
        let table = DayTableView(frame: safeArea.layoutFrame)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: DayTableView.reuseIdentifier, for: indexPath) as! GoalCell
        
        let bounds = cell.bounds
        
        let hStack = UIStackView(frame: bounds)
        hStack.axis = .horizontal

        hStack.backgroundColor = .systemGray
        
        let goalDay = try? dbQueue?.read({ db in
            return try goals[indexPath.row].dayCreated.fetchOne(db)
        })
        
        let marginPercent = 0.1
        let lrMargins = bounds.width * CGFloat(marginPercent)
        
        let heightPercent = 0.1
        let cellHeight = view.bounds.height * CGFloat(heightPercent)
        
        let leftLabel = UILabel()
        leftLabel.text = goals[indexPath.row].description
        

        let rightLabel = UILabel()
        rightLabel.text = goalDay!.date
        
        
//        let left = UIView(frame: bounds)
//        left.addSubview(leftLabel)
//
//
//        let right = UIView(frame: bounds)
//        right.addSubview(rightLabel)
//
//
//        hStack.addArrangedSubview(left)
//        hStack.addArrangedSubview(right)
//
//        cell.addSubview(hStack)
//        left.translatesAutoresizingMaskIntoConstraints = false
//        right.translatesAutoresizingMaskIntoConstraints = false
        
        cell.backgroundColor = .systemGray3
        
        hStack.addArrangedSubview(leftLabel)
        hStack.addArrangedSubview(rightLabel)
        
        cell.addSubview(hStack)
        
        hStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hStack.widthAnchor.constraint(equalTo: cell.widthAnchor, constant: -lrMargins),
            hStack.heightAnchor.constraint(equalTo: cell.heightAnchor, constant: cellHeight),
            hStack.centerXAnchor.constraint(equalTo: cell.centerXAnchor),
            hStack.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
        ])
        
        return cell
    }
}
