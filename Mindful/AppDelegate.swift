//
//  AppDelegate.swift
//  Mindful
//
//  Created by William Shelley on 6/4/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import UIKit
import GRDB

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private func initializeDB(in application: UIApplication) {
        let databaseURL = try! FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent(dbName)
        
        migrations = [createDays, createGoals, createBadges]
        dbQueue = try? DBManager.connectDB(atPath: databaseURL.path, withMigrations: migrations)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initializeDB(in: application)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

