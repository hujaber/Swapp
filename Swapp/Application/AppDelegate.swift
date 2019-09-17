//
//  AppDelegate.swift
//  Swapp
//
//  Created by Hussein Jaber on 17/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var applicationCoordinator: ApplicationCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = .init(frame: UIScreen.main.bounds)
        if #available(iOS 13, *) {
            window?.backgroundColor = .systemBackground
        } else {
            window?.backgroundColor = .white
        }
        applicationCoordinator = .init(window: window!)
        applicationCoordinator.start()
        return true
    }


}

