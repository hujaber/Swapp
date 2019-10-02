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
        setupNavigationBarAppearance()
        return true
    }
    
    private func setupNavigationBarAppearance() {
        if #available(iOS 13.0, *) {
                  let appearance = UINavigationBarAppearance()
                  appearance.backgroundColor = .systemBackground
                  appearance.backgroundEffect = nil
                  appearance.shadowColor = nil
                  appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemTeal]
                  appearance.titleTextAttributes = [.foregroundColor: UIColor.systemTeal]
                 // appearance.tintColor = .white
                  UINavigationBar.appearance().scrollEdgeAppearance = appearance
                  UINavigationBar.appearance().compactAppearance = appearance
                  UINavigationBar.appearance().standardAppearance = appearance
                  UINavigationBar.appearance().tintColor = .systemTeal
              } else {
                  UINavigationBar
                      .appearance()
                    .barTintColor = .white
                  UINavigationBar.appearance().tintColor = UIColor.appThemeColor
                  UINavigationBar.appearance().isTranslucent = false
                  UINavigationBar
                      .appearance()
                      .titleTextAttributes = [
                          NSAttributedString.Key.foregroundColor : UIColor.lightGray
                  ]
            UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)]
              }
    }


}

