//
//  CalendarDay.swift
//  Mindful
//
//  Created by William Shelley on 6/25/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import Foundation
import GRDB

class Day: Record {

    var id: Int64?
    var date: String

    enum Columns: String, ColumnExpression {
        case id, date
    }

    override class var databaseTableName: String { "days" }

    init(id: Int64?, date: String) {
        self.id = id
        self.date = date
        super.init()
    }

    required init(row: Row) {
        id = row[Columns.id]
        date = row[Columns.date]
        super.init(row: row)
    }


    override func encode(to container: inout PersistenceContainer) {
        container[Columns.id] = id
        container[Columns.date] = date
    }

    override func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }

}

