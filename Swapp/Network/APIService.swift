//
//  APIService.swift
//  Swapp
//
//  Created by Hussein Jaber on 18/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import RxSwift

protocol ExecutableService {
    var dispatcher: NetworkDispatcher { get }
    var disposeBag: DisposeBag { get }
}

extension ExecutableService {
    func execute<T: InitableFromDictionary>(operation: DefaultOperation<T>) -> Observable<T> {
        let op = HTTPIntermediateGenericOperation(operation: operation)
            .execute(in: dispatcher)
        return Observable<T>.create { ob in
            op.subscribe(onNext: { (response) in
                if let data = response.data {
                    ob.onNext(data)
                    ob.onCompleted()
                } else {
                    ob.onError(response.error!)
                }
            },
                         onError: { (error) in
                            ob.onError(error)
            })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
}

final class APIService: ExecutableService {
    var dispatcher: NetworkDispatcher = NetworkDispatcherFactory.mockDispatcher
    var disposeBag: DisposeBag = .init()
    
    func fetchCategories() -> Observable<[Category]> {
        let request = CategoriesRequest()
        let op = DefaultOperation<APIArrayResponse<Category>>(request: request)
        return execute(operation: op).map({ $0.data })
    }
    
    func fetchStoresForCategoryId(_ id: Int) -> Observable<[Store]> {
        let request = StoreRequest(categoryId: id)
        let op = DefaultOperation<APIArrayResponse<Store>>(request: request)
        return execute(operation: op).map({$0.data})
    }
  
}
