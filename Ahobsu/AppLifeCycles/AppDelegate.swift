//
//  AppDelegate.swift
//  Ahobsu
//
//  Created by 이호찬 on 2019/11/17.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupViewAppearance()
        setupFirebase()
        return true
    }
    
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication,
                     didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

extension AppDelegate {
    
    private func setupViewAppearance() {
        UINavigationBar.appearance().tintColor = .rosegold
    }
    
    private func setupFirebase() {
        FirebaseApp.configure()
    }
}
