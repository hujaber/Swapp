//
//  CategoriesRequests.swift
//  Swapp
//
//  Created by Hussein Jaber on 18/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import Foundation

//store items: https://api.myjson.com/bins/1f6vmx

struct CategoriesRequest: Request {
    var path: String {
        "15lssp"
    }
}

struct StoreRequest: Request {
    let categoryId: Int
    var path: String {
        "7q8h5"
    }
}

struct StoreItemsRequest: Request {
    let storeId: Int
    var path: String {
        "1f6vmx"
    }
}


