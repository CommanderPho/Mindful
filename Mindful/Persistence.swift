//
//  Persistence.swift
//  Mindful
//
//  Created by William Shelley on 6/16/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import Foundation

//        let date = Date(timeIntervalSinceNow: 0).description

//        for (key, value) in defaults.dictionaryRepresentation() {
//            defaults.removeObject(forKey: key)
//
//        }
//        for (key, value) in defaults.dictionaryRepresentation() {
//            print("\(key) = \(value) \n")
//        }

let EARNED_BADGES_PERSIST_KEY = "BadgesEarned"
let KEYS = [EARNED_BADGES_PERSIST_KEY]


func storeInDefaults(value data: Any, atKey key: String){
    UserDefaults.standard.set(data, forKey: key)
}

func removeFromDefaults(fromKey key:String){
    UserDefaults.standard.removeObject(forKey: key)
}

func findEarnedBadgesByKey() -> Dictionary<String, Any> {
    return UserDefaults.standard.object(forKey: EARNED_BADGES_PERSIST_KEY) as? Dictionary <String, Any> ?? [String:Any]()
}

func clearDefaults(){
    for (key, _) in UserDefaults.standard.dictionaryRepresentation() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}

func printDefaults(){
    showDefaults(presentationMethod: {(k: Any, v:Any)->Void in
        print(k,v,"\n")
    })
}

func showDefaults(presentationMethod callback: (Any, Any)->Void){
    let dict = UserDefaults.standard.dictionaryRepresentation()
    for key in KEYS {
        callback(key, dict[key] ?? "Bad Dict")
    }
}

func badgeInDefaults(title: String) -> Bool{
    let defaults = UserDefaults.standard
    let badgeDict =
        defaults.object(forKey: EARNED_BADGES_PERSIST_KEY)
            as? Dictionary<String, Any> ?? [String : Any]()
    return badgeDict[title] != nil
}
