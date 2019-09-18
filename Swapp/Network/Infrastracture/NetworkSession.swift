//
//  NetworkSession.swift
//  Swapp
//
//  Created by Hussein Jaber on 18/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import Foundation

protocol NetworkSessionProtocol {
    var session: URLSession { get }
}

final class NetworkSession: NetworkSessionProtocol {
    
    // MARK: Private methods
    
    private let sessionDescription = "com.swapp.session"
    
    // MARK: Public properties
    
    let session: URLSession
    let configuration: SessionConfigurationProtocol
    
    static let shared = NetworkSession(configuration: SessionConfiguration())
    
    // MARK: Constructors
    
    /// Designated initializer
    ///
    /// The session delegate is set to nil and will use the "system" provided
    /// delegate
    ///
    /// - returns: Session

    init(configuration: SessionConfigurationProtocol) {
        self.configuration = configuration
        self.session = .init(configuration: configuration.sessionConfiguration,
                             delegate: nil,
                             delegateQueue: OperationQueue.main)
        self.session.sessionDescription = sessionDescription
    }
}
