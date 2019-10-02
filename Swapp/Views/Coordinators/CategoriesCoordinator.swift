//
//  CategoriesCoordinator.swift
//  Swapp
//
//  Created by Hussein Jaber on 20/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//
import UIKit
import RxSwift

protocol Coordinator {
    var rootController: UINavigationController { get }
}

final class CategoriesCoordinator: Coordinator {
    
    var rootController: UINavigationController
    private let disposeBag = DisposeBag()
    
    init(with rootController: UINavigationController = .init()) {
        self.rootController = rootController
        let categoriesController = CategoriesController()
        categoriesController
            .didSelectCategory
            .bind { [weak self] in self?.showStores(for: $0) }
            .disposed(by: disposeBag)
        rootController.viewControllers = [categoriesController]
        rootController.navigationBar.prefersLargeTitles = true
        
    }
    
    private func showStores(for category: Category) {
        let storesController = StoresController.controllerInStoryboard(.Categories)
        storesController.navigationItem.title = category.name
        storesController.navigationItem.largeTitleDisplayMode = .never
        storesController.viewModel.category = category
        storesController.didSelectStore.bind { [weak self] in self?.showStoreItems(for: $0.categoryId)
            #warning("Replace with store ID")
        }.disposed(by: disposeBag)
        rootController.pushViewController(storesController, animated: true)
    }
    
    private func showStoreItems(for storeId: Int) {
        let storeItemsController = StoreItemsController.controllerInStoryboard(.Categories)
        storeItemsController.viewModel.storeId = storeId
        storeItemsController.navigationItem.title = ""
        storeItemsController.navigationItem.largeTitleDisplayMode = .never
        rootController.pushViewController(storeItemsController, animated: true)
    }
    
}

