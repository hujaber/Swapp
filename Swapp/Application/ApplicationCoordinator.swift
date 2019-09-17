//
//  ApplicationCoordinator.swift
//  Swapp
//
//  Created by Hussein Jaber on 17/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import UIKit
import RxSwift

final class ApplicationCoordinator {
    
    private let window: UIWindow!
    private var navigationController: UINavigationController!
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let main = MainTabController.controllerInStoryboard(.Main)
        
        navigationController = .init(rootViewController: main)
        navigationController.setNavigationBarHidden(true, animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
