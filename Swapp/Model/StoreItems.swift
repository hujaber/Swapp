//
//  StoreItems.swift
//  Swapp
//
//  Created by Hussein Jaber on 25/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import Foundation

struct StoreCategories: InitableFromDictionary {
    let id: Int
    let name: String
    let storeId: Int
    let items: [CartItem]
    
    init(fromDictionary dictionary: [String : Any]) throws {
        guard let id = dictionary[.id] as? Int
            else { throw SerializationError.missing(.id) }
        guard let name = dictionary[.name] as? String
            else { throw SerializationError.missing(.name) }
        guard let storeId = dictionary[.store_id] as? Int
            else { throw SerializationError.missing(.store_id) }
        guard let itemsDictionary = dictionary[.items] as? [[String:Any]]
            else { throw SerializationError.missing(.items)}
        
        self.id = id
        self.name = name
        self.storeId = storeId
        self.items = try itemsDictionary.map { try StoreItem(fromDictionary: $0) }
    }
}

struct StoreItem: CartItem, InitableFromDictionary {
    var id: Int
    
    var price: Double
    
    var count: Int = 0
    
    var description: String
    
    var imageUrl: String
    
    var name: String
    
    init(fromDictionary dictionary: [String : Any]) throws {
        guard let id = dictionary[.id] as? Int
            else { throw SerializationError.missing(.id) }
        guard let price = dictionary[.price] as? Double
            else { throw SerializationError.missing(.price) }
        guard let description = dictionary[.description] as? String
            else { throw SerializationError.missing(.description) }
        guard let imageUrl = dictionary[.item_image] as? String
            else { throw SerializationError.missing(.item_image) }
        guard let name = dictionary[.name] as? String
            else { throw SerializationError.missing(.name) }
        
        self.id = id
        self.price = price
        self.description = description
        self.imageUrl = imageUrl
        self.name = name
    }
    
}
