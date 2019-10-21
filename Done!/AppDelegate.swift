//
//  AppDelegate.swift
//  Done!
//
//  Created by Flavio Scerra on 20/10/2019.
//  Copyright © 2019 flavio scerra. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var  window: UIWindow?
    var dataModel = DataModel()



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationController = window?.rootViewController as? UINavigationController
        let projectVC = navigationController?.viewControllers[0] as? ProjectsViewController
        projectVC?.dataModel = dataModel
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        dataModel.saveProjects()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        dataModel.saveProjects()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        dataModel.saveProjects()
    }

    // MARK: UISceneSession Lifecycle
    
    @available(iOS 13, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

