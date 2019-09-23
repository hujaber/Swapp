//
//  Category.swift
//  Swapp
//
//  Created by Hussein Jaber on 18/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import Foundation

struct Category: InitableFromDictionary {
    let id: Int
    let name: String
    
    init(fromDictionary dictionary: [String : Any]) throws {
        guard let id = dictionary[.id] as? Int
            else {
                throw SerializationError.missing(.id)
        }
        guard let name = dictionary[.name] as? String
            else { throw SerializationError.missing(.name) }
        self.id = id
        self.name = name
    }
}
