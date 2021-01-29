//
//  AppDelegate.swift
//  TelstraPOC
//
//  Created by Anil Gupta on 17/12/20.
//  Copyright © 2020 Anil Gupta. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
     var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        let rootController = HomeViewController(nibName: nil, bundle: nil)
        navigationController.viewControllers = [rootController]
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        return true
    }
}
