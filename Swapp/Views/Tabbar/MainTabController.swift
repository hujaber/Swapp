//
//  MainTabController.swift
//  Swapp
//
//  Created by Hussein Jaber on 17/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import UIKit
import RxSwift

final class MainTabController: UITabBarController {
    
    private enum Controllers: Int, CaseIterable {
        case home = 0
        case search
//        case profile
        
        var title: String {
            switch self {
            case .home:
                return "Home"
            case .search:
                return "Search"
//            case .profile:
//                return "Profile"
            
            }
        }
    }
    
    private let categoriesCoordinator: CategoriesCoordinator = .init()
    private let searchCoordinator: SearchCoordinator = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
        setupTabBar()
    }

    private func setupControllers() {
        setViewControllers([categoriesCoordinator.rootController, searchCoordinator.rootController], animated: true)
    }
    
    private func setupTabBar() {
        if #available(iOS 13, *) {
            tabBar.unselectedItemTintColor = .systemGray
        } else {
            tabBar.unselectedItemTintColor = .gray
        }
        
        Controllers
            .allCases
            .forEach({ tabBar.items?[$0.rawValue].title = $0.title })
    }

}
