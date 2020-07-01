//
//  ApplicationRecord.swift
//  Mindful
//
//  Created by William Shelley on 6/26/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import GRDB

protocol ApplicationRecord: Codable, PersistableRecord, FetchableRecord, Identifiable, Hashable {}


func hashModel<T: ApplicationRecord>(_ t: T) -> [String: Any] {
    var hash: [String: Any] = [:]
    let mirrored = Mirror(reflecting: t)
    for attr in mirrored.children {
        hash[attr.label!] = attr.value
    }
    return hash
}

