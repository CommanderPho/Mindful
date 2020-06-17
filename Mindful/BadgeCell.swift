//
//  BadgeCell.swift
//  Mindful
//
//  Created by William Shelley on 6/15/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import UIKit

class Badge {
    var id: String
    var title: String
    var description: String
    var iconName: String
    
    init(title: String, description: String, iconName: String){
        self.id = title
        self.title = title
        self.description = description
        self.iconName = iconName
    }
    
    func store(){
        var currentStore = findEarnedBadgesByKey()
        currentStore[self.id] = self.toDict()
        storeInDefaults(value: currentStore, atKey: EARNED_BADGES_PERSIST_KEY)
    }
    
    func toDict() -> [String:Any] {
        return [
            "id": self.id,
            "title": self.title,
            "description": self.description,
            "iconName": self.iconName
        ]
    }
    
    func isUndiscovered() -> Bool {
        return self.title == "?"
    }
    
    static func loadFromDict(options: Dictionary<String, Any>) -> Badge {
        let title = options["title"] as? String ?? "title"
        let description = options["description"] as? String ?? "description"
        let iconName = options["iconName"] as? String ?? "rosette"
        return Badge(title: title, description: description, iconName: iconName)
    }
    
    static func storeBadges(badges: [Badge]){
        storeInDefaults(value: badges, atKey: EARNED_BADGES_PERSIST_KEY)
    }
    
//    func isEarned() -> Bool{
//        let defaults = UserDefaults.standard
//        let badgeDict =
//            defaults.object(forKey: EARNED_BADGES_PERSIST_KEY)
//                as? Dictionary<String, Any> ?? [String : Any]()
//
//        return badgeDict[self.title] != nil
//    }
//
//    func store(){
//        let defaults = UserDefaults.standard
//        var badgeDict =
//            defaults.object(forKey: EARNED_BADGES_PERSIST_KEY)
//                as? Dictionary<String, Any> ?? [String : Any]()
//
//        if badgeDict[self.title] == nil || (badgeDict[self.title] as! Dictionary<String,Any>).isEmpty {
//            badgeDict[self.title] = self.toDict()
//        } else {
//            badgeDict[self.title] = nil
//        }
//        storeInDefaults(value: badgeDict, atKey: EARNED_BADGES_PERSIST_KEY)
//    }
//
//    func toDict() -> Dictionary<String, Any> {
//        return [
//            "title": self.title,
//            "description": self.description,
//            "iconName": self.iconName
//        ]
//    }
//
//    static func loadFromDict(dict: Dictionary<String, Any>) -> Badge {
//        return Badge(title: dict["title"] as! String,
//                     description: dict["description"] as! String,
//                     iconName: dict["iconName"] as! String)
//    }
}
