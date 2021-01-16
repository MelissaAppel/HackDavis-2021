//
//  AppDelegate.swift
//  HackDavis
//
//  Created by Melissa Appel on 1/16/21.
//
//
//  AppDelegate.swift
//  evolv
//
//  Created by Aryan Vaid on 5/26/20.
//  Copyright © 2020 Evolv Ideas. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

@UIApplicationMain
    class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        UINavigationBar.appearance().isHidden = false
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String
        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication:sourceApplication) ?? false {
            return true
        }
        return false
    }
    
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

