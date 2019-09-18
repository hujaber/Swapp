//
//  CategoriesViewModel.swift
//  Swapp
//
//  Created by Hussein Jaber on 18/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class CategoriesViewModel {
    private let apiServices = APIService()
    private let disposeBag = DisposeBag()
    let fetchedCategories = BehaviorRelay<[Category]>(value: [])
    
    func fetchCategories() {
        apiServices
            .fetchCategories()
            .bind(to: fetchedCategories)
            .disposed(by: disposeBag)
    }
}
