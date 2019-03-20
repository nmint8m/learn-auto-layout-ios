//
//  AppDelegate.swift
//  DemoAutoLayoutGuide
//
//  Created by Tam Nguyen M. on 3/20/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        window?.rootViewController = MenuVC()
        return true
    }
}

