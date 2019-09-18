//
//  SessionConfiguration.swift
//  Swapp
//
//  Created by Hussein Jaber on 18/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import Foundation

protocol SessionConfigurationProtocol {
    var requestTimeOut: Double { get }
    var resourceTimeOut: Double { get }
    var httpMaximumConnectionsPerHost: Int { get }
    var sessionConfiguration: URLSessionConfiguration { get }
    init()
}

final class SessionConfiguration: SessionConfigurationProtocol {
    var requestTimeOut: Double = 30
    var resourceTimeOut: Double = 60
    var httpMaximumConnectionsPerHost: Int = 2
    var sessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default
    
    lazy private var cache: URLCache = {
        let memoryCacheLimit: Int = 10 * 1024 * 1024
        let diskCapacity: Int = 50 * 1024 * 1024
        let cache: URLCache = URLCache(memoryCapacity: memoryCacheLimit, diskCapacity: diskCapacity, diskPath: nil)
        return cache
    }()
    
    init() {
        let additionalHeaders: [String: String] = [
            "Accept": "application/json",
            "Content-Type": "application/json; charset=UTF-8"
        ]
        self.sessionConfiguration.requestCachePolicy = .reloadIgnoringLocalCacheData
        self.sessionConfiguration.timeoutIntervalForRequest = self.requestTimeOut
        self.sessionConfiguration.timeoutIntervalForResource = self.resourceTimeOut
        self.sessionConfiguration.httpAdditionalHeaders = additionalHeaders
        self.sessionConfiguration.httpMaximumConnectionsPerHost = self.httpMaximumConnectionsPerHost
        self.sessionConfiguration.urlCache = self.cache
    }
}
