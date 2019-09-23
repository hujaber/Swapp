//
//  APIKey.swift
//  Swapp
//
//  Created by Hussein Jaber on 23/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import Foundation

enum APIKey: String {
    case data
    case status
    case id
    case name
    case category_id
    case description
    case store_cover
    case store_logo
}

//"id": 1,
//          "category_id": 2,
//          "name": "Burger Man",
//          "description": "International Food",
//          "store_cover": "{url}",
//          "store_logo": "{url}"


extension Dictionary where Key: ExpressibleByStringLiteral {
    subscript(jsonKey: APIKey) -> Value? {
        get {
            return self[jsonKey.rawValue as! Key]
        }
        set {
            self[jsonKey.rawValue as! Key] = newValue
        }
    }
}


