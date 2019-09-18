//
//  HTTPOperation.swift
//  Swapp
//
//  Created by Hussein Jaber on 18/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import RxSwift

protocol HTTPOperation {
    associatedtype Output
    var request: Request { get }
    func execute(in dispatcher: Dispatcher) -> Observable<Output>
}

extension HTTPOperation where Output: InitableFromDictionary {
    func execute(in dispatcher: Dispatcher) -> Observable<InitableFromDictionary> {
        return Observable.create { ob in
            dispatcher.execute(request: self.request) { (response) in
                switch response {
                case .data(_):
                    ob.onError(Response.NetworkError.mismatchData)
                case .error(let err):
                    ob.onError(err!)
                case .json(let json):
                    do {
                        let model = try Output(fromDictionary: json)
                        ob.onNext(model)
                        ob.onCompleted()
                    } catch { ob.onError(error) }
                }
            }
            return Disposables.create()
        }
    }
}

// An operation object which handles an object conforming to `InitableFromDictionary`
struct DefaultOperation<T>: HTTPOperation where T: InitableFromDictionary {
    var request: Request
    typealias Output = T
    
    func execute(in dispatcher: Dispatcher) -> Observable<T> {
        return Observable.create { ob in
            dispatcher.execute(request: self.request) { (response) in
                switch response {
                case .data(_):
                    ob.onError(Response.NetworkError.mismatchData)
                case .error(let err):
                    ob.onError(err!)
                case .json(let json):
                    do {
                        let model = try Output(fromDictionary: json)
                        ob.onNext(model)
                        ob.onCompleted()
                    } catch { ob.onError(error) }
                }
            }
            return Disposables.create()
        }

    }
}


// Updated version of the IntermediateGenericOperation, conforming to new protocol
struct HTTPIntermediateGenericOperation<T: HTTPOperation>: HTTPOperation {

    var request: Request {
        self.operation.request
    }
    
    typealias Output = (error: Response.NetworkError?, data: T.Output?)
    
    let operation: T
    
    func execute(in dispatcher: Dispatcher) ->
        Observable<(error: Response.NetworkError?, data: T.Output?)> {
            
        return Observable.create { observable in
            self.operation.execute(in: dispatcher).subscribe(onNext: { (data) in
                observable.onNext((nil, data))
                observable.onCompleted()
            }, onError: { (error) in
                observable.onNext((error as? Response.NetworkError, nil))
            })
        }
    }
}

///Struct holding an Array response structure
struct APIArrayResponse<T: InitableFromDictionary> : InitableFromDictionary {
    ///Returns Array Of T Model type
    let data: [T]
    ///Returns response status type hopefully 200 :P
    let status: Int?

    init(fromDictionary dictionary: [String : Any]) throws {
        guard let dataArray = dictionary["data"] as? [[String:Any]] else { throw SerializationError.missing(APIKey.data)}
        self.status = dictionary[APIKey.status.rawValue] as? Int
        self.data = try dataArray.compactMap { try T(fromDictionary: $0) }
    }
}


enum SerializationError: Swift.Error {
    case missing(APIKey)
}

enum APIKey: String {
    case data
    case status
}



