//
//  Dispatcher.swift
//  Swapp
//
//  Created by Hussein Jaber on 18/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import Foundation
import RxSwift

typealias APICompletionHandler = (Response) -> Void

protocol Dispatcher {
    
    /// Configure the dispatcher with an environment
    ///
    /// - Parameter environment: environment configuration
    init(environment: Environment)
    
    /// This function execute the request and provide a callback
    /// with the response.
    ///
    /// - Parameter:
    ///     - request: request to execute
    ///     - completionHandler: a completion handler check TrellisAPICompletionHandler
    /// - Returns: nothing
    func execute(request: Request, completionHandler: @escaping APICompletionHandler)
    
    /// Cancels a request
   // func cancelRequest()
    
}

final class NetworkDispatcher: Dispatcher {
    
    private var task: URLSessionDataTask?
    private var environment: Environment
    
    init(environment: Environment) {
        self.environment = environment
    }
    
    func execute(request: Request, completionHandler: @escaping APICompletionHandler) {
        do {
            let req = try prepareURLRequest(for: request)
            task = self.environment.session.dataTask(with: req, completionHandler: { (dataOptional, response, error) -> Void in
                
                let response = Response( (response as? HTTPURLResponse, dataOptional, error), for: request)
                completionHandler(response)
            })
            task?.resume()
            
        } catch let e {
            let response = Response( (nil, nil, e), for: request)
            completionHandler(response)
        }
    }
 
    
    /// Prepare the request for execution
    ///
    /// - Parameter request: network request
    /// - Throws: NetworkError enum case
    /// - Returns: an URLRequest

    private func prepareURLRequest(for request: Request) throws -> URLRequest {
        var full_url = "\(environment.host)/\(request.path)"
        if environment.host.isEmpty {
            full_url = request.path
        }
        
        var urlRequest = URLRequest(url: URL(string: full_url)!)
        
        switch request.parameters {
        case .body(let params):
            if let params = params {
                let jsonData = try JSONSerialization.data(withJSONObject: params, options: .init(rawValue: 0))
                urlRequest.httpBody = jsonData
            } else {
                throw Response.NetworkError.badInput
            }
        case .url(let params):
            if let params = params as? [String: String] {
                let queryParams = params.map { URLQueryItem(name: $0.key, value: $0.value)}
                guard var components = URLComponents(string: full_url) else {
                    throw Response.NetworkError.badInput
                }
                components.queryItems = queryParams
                urlRequest.url = components.url
            } else {
                throw Response.NetworkError.badInput
            }
        case .noParams:
            break
        }
         // Add headers from enviornment and request
         environment.headers.forEach { urlRequest.addValue($0.value as! String, forHTTPHeaderField: $0.key) }
         request.headers?.forEach { urlRequest.addValue($0.value as! String, forHTTPHeaderField: $0.key) }
         
         // Setup HTTP method
         urlRequest.httpMethod = request.method.rawValue
         
         return urlRequest

    }
}

///struct for creating a suitable Network Dispatcher
struct NetworkDispatcherFactory {
    
    /// Returns a network dispatcher (development or production according to the DEBUG flag). Checks for usertype and returns appropriate dispatcher
    static func getDispatcher() -> NetworkDispatcher {
        #if DEBUG
        return developmentEnvironmentDispatcher
        #else
        return productionEnvironmentDispatcher
        #endif
    }
    
    static var mockDispatcher: NetworkDispatcher {
        mockEnvironmentDispatcher
    }
    
    fileprivate static let mockEnvironmentDispatcher: NetworkDispatcher = {
        NetworkDispatcher(environment: EnvironmentFactory.mockEnvironment)
    }()
    
    /// Get a development dispatcher
    ///
    /// - Returns: Development dispatcher
    fileprivate static let developmentEnvironmentDispatcher: NetworkDispatcher = {
        let dispatcher = NetworkDispatcher(environment: EnvironmentFactory.developmentEnvironment)
        return dispatcher
    }()
    
    /// Get a production dispatcher
    ///
    /// - Returns: Production dispatcher
    fileprivate static let productionEnvironmentDispatcher: NetworkDispatcher = {
        let dispatcher = NetworkDispatcher(environment: EnvironmentFactory.productionEnvironment)
        return dispatcher
    }()
}



