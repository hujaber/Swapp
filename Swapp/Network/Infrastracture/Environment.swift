//
//  Environment.swift
//  Swapp
//
//  Created by Hussein Jaber on 18/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import Foundation

/// Working Environment Type

enum EnvironmentType {
    case dev
    case prod
    case mock
}

// conformance to CustomDebugStringConvertible
extension EnvironmentType : CustomDebugStringConvertible {
    
    var debugDescription: String {
        var text: String = ""
        switch self {
        case .dev:
            text = "Development"
        case .prod:
            text = "Production"
        case .mock:
            text = "Mock"
        }
        return text
    }
}

/**
    Environment is a struct which encapsulate all the informations
we need to perform a setup of our Networking Layer.
we just define the type of the environment (ie. Production,
Test Environment #1 and so on) and the base url to complete requests.
We may also want to include any SSL certificate or wethever you need.
*/

public struct Environment {
    public lazy var session: URLSession = {
        NetworkSession.shared.session
    }()
    
    /// Type of the environment
    var type: EnvironmentType
    
    /// Base URL of the environment
    public var host: String
    
    
    /// This is the list of common headers which will be part of each Request
    /// Some headers value maybe overwritten by Request's own headers
    public var headers: [String: Any] = [:]
    
    /// Initialize a new Environment
    ///
    /// - Parameters:
    ///   - type: type of the environment
    ///   - host: base url
    init(_ type: EnvironmentType, host: String) {
        self.type = type
        self.host = host
    }

}

///A helper struct to facilitate dev/prod env setup
public struct EnvironmentFactory {
    
    /// Get a production environment
    ///
    /// - Returns: Production Environmenr
    public static let productionEnvironment: Environment = {
        let env = Environment(.prod, host: "https://findreapp.com/api")
        return env
    }()
    
    /// Get a development environment
    ///
    /// - Returns: Development environment
    public static let developmentEnvironment: Environment = {
        let env = Environment(.dev, host: "https://dev.findreapp.com/api")
        return env
    }()
    
    public static let mockEnvironment: Environment = {
        let env = Environment(.mock, host: "https://api.myjson.com/bins")
        return env
    }()
    
}
