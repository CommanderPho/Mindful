//
//  ApplicationRecord.swift
//  Mindful
//
//  Created by William Shelley on 6/26/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import GRDB

protocol ApplicationRecord: Codable, PersistableRecord, FetchableRecord, Identifiable {}
