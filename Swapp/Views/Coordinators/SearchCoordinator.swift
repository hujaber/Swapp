//
//  SearchCoordinator.swift
//  Swapp
//
//  Created by Hussein Jaber on 20/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import UIKit

final class SearchCoordinator: Coordinator {
    var rootController: UINavigationController
    
    init(rootController: UINavigationController = UINavigationController()) {
        self.rootController = rootController
        let searchController = SearchController.controllerInStoryboard(.Search)
        rootController.viewControllers = [searchController]
        rootController.navigationBar.prefersLargeTitles = true
    }
    
}
