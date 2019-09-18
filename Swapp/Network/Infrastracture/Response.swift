//
//  Response.swift
//  Swapp
//
//  Created by Hussein Jaber on 18/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import Foundation

import Foundation

public enum Response {
    /// Enums holds the different network error types that might occure
    public enum NetworkError: Error {
        case error(Error)
        case notFound
        case unpackingJSON
        case serverConnection
        case badInput
        case noData
        case unknown
        case serverError(Int)
        case clientError(Int)
        case requestError(String?, Int?)
        case mismatchData
        case insufficientData
        case noRequests
        case authTokenExpired
        case invalidRefreshToken
        case invalidCredentials
        case emailDoesNotExists
        case emailAlreadyExists
        case fullnameTooShort
        case wrongPassword
        case emailNotVerified
    }
    
    case json(_: [String: Any])
    case data(_: Data)
    case error(NetworkError?)
    
    init(_ response: (r: HTTPURLResponse?, data: Data?, error: Error?), for request: Request) {
        if let d = response.data {
            print(String(data: d, encoding: .utf8) ?? "No error message received")
            if let jsonObject = try? JSONSerialization.jsonObject(with: d, options: []) as? [String: Any] {
                if let errorObject = jsonObject["error"] as? [String: Any] {
                    if let errorCode = errorObject["code"] as? Int {
                        print(String(data: d, encoding: .utf8) ?? "No error message received")
                        print("Error code: ____ \(errorCode)")
                        switch errorCode {
                        case 2001:
                            self = .error(.noRequests)
                        case 666:
                            self = .error(.authTokenExpired)
                            //AppDelegate.shared.showSyncController()
                        case 667:
                            self = .error(.emailNotVerified)
                        case 1003:
                            self = .error(Response.NetworkError.fullnameTooShort)
                        case 1005:
                            self = .error(.emailAlreadyExists)
                        case 1006:
                            self = .error(.emailDoesNotExists)
                        case 1013:
                            self = .error(.invalidCredentials)
                        case 1014:
                            self = .error(.invalidRefreshToken)
                           // SessionManager.logoutToMainScreen()
                        case 1017:
                            self = .error(.wrongPassword)
                        default:
                            self = .error(NetworkError.unknown)
                        }
                        return
                    }
                }
            }
        }
        
        if let e = response.error {
            self = .error(NetworkError.requestError(e.localizedDescription, 0))
            return
        }
        
        guard let statusCode = response.r?.statusCode else {
            self = .error(NetworkError.unknown)
            return
        }
        
        switch statusCode {
            
        case 200:
            
            // If we don't get data back, alert the user.
            guard let data = response.data else {
                self = .error(NetworkError.serverConnection)
                return
            }
            
            do {
                
                switch request.dataType {
                case .data:
                    self = .data(data)
                case .json:
                    if let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
                        self = .json(jsonDictionary)
                    } else {
                        self = .error(.unpackingJSON)
                    }
                }
            } catch {
                self = .error(NetworkError.unpackingJSON)
            }
        case 401:
            self = .error(NetworkError.notFound)
        case 404:       self = .error(NetworkError.notFound)
        case 400...499: self = .error(NetworkError.clientError(statusCode))
        case 500...599: self = .error(NetworkError.serverError(statusCode))
            
        default:
            self = .error(NetworkError.unknown)
        }
    }
}
