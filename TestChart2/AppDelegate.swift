//
//  AppDelegate.swift
//  TestChart2
//
//  Created by User on 06.03.18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setupApp(application)
        
        return true
    }
    
    fileprivate func setupApp(_ application: UIApplication) {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        
        let vcStart = HelperManager.getController(WLStartController.kIdentifier, forStoryboardName: Constants.Storyboard.main)
        let navController = UINavigationController.init(rootViewController: vcStart)
        navController.navigationBar.tintColor = .white
        navController.navigationBar.barTintColor = UIColor.init(red: 51/255, green: 90/255, blue: 149/255, alpha: 1.0)
        navController.navigationBar.isTranslucent = false
        
        prepareNavigationBar()
        
        self.window?.rootViewController = navController
    }
    
    fileprivate func prepareNavigationBar() {
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        UINavigationBar.appearance().backgroundColor = .blue
    }

}

