//
//  Store.swift
//  Swapp
//
//  Created by Hussein Jaber on 18/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import Foundation

struct Store: InitableFromDictionary {
    let categoryId: Int
    let name: String
    let description: String
    let storeCoverImageUrl: String?
    let storeLogoImageUrl: String?
    
    init(fromDictionary dictionary: [String : Any]) throws {
        guard let categoryId = dictionary[.category_id] as? Int
            else { throw SerializationError.missing(.category_id) }
        guard let name = dictionary[.name] as? String
            else { throw SerializationError.missing(.name) }
        guard let description = dictionary[.description] as? String
            else { throw SerializationError.missing(.description) }
        self.categoryId = categoryId
        self.name = name
        self.description = description
        self.storeLogoImageUrl = dictionary[.store_cover] as? String
        self.storeCoverImageUrl = dictionary[.store_logo] as? String
    }
}
