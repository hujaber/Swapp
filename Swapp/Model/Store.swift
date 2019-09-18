//
//  Store.swift
//  Swapp
//
//  Created by Hussein Jaber on 18/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import Foundation

//"id": 1,
//          "category_id": 2,
//          "name": "Burger Man",
//          "description": "International Food",
//          "store_cover": "{url}",
//          "store_logo": "{url}"
struct Store: InitableFromDictionary {
    let categoryId: Int
    let name: String
    let description: String
    let storeCoverImageUrl: String?
    let storeLogoImageUrl: String?
    
    init(fromDictionary dictionary: [String : Any]) throws {
        self.categoryId = dictionary["category_id"] as! Int
        self.name = ""
        self.description = ""
        self.storeLogoImageUrl = nil
        self.storeCoverImageUrl = nil
    }
}
