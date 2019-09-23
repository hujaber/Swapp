//
//  StoresViewModel.swift
//  Swapp
//
//  Created by Hussein Jaber on 22/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import RxSwift
import RxCocoa

final class StoresViewModel {
    
    private let disposeBag = DisposeBag()
    
    var category: Category! {
        didSet {
            fetchStores()
        }
    }
    
    private let apiService = APIService()
    
    let fetchedStores = BehaviorSubject<[Store]>(value: [])
    
    private func fetchStores() {
        apiService
            .fetchStoresForCategoryId(category.id)
            .bind(to: fetchedStores)
            .disposed(by: disposeBag)
    }
    
}
