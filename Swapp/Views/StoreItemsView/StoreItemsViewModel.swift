//
//  StoreItemsViewModel.swift
//  Swapp
//
//  Created by Hussein Jaber on 25/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import RxSwift
import RxCocoa

final class StoreItemsViewModel {
    private let apiService: APIService = .init()
    private let disposeBag = DisposeBag()
    var storeId: Int! {
        didSet {
            fetchItems()
        }
    }
    
    let fetchedItems = BehaviorSubject<[StoreCategories]>(value: [])
    
    private func fetchItems() {
        apiService
            .fetchStoreItems(storeId: storeId)
            .bind(to: fetchedItems)
            .disposed(by: disposeBag)
    }
    
}
