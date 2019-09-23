//
//  CartTests.swift
//  SwappTests
//
//  Created by Hussein Jaber on 22/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import XCTest
@testable import Swapp

class CartTests: XCTestCase {
    
    struct Item: CartItem {
        var id: Int
        var count: Int
        var price: Double
    }
    
    var items: [CartItem] = []

    override func setUp() {
        let item1 = Item(id: 1, count: 1, price: 19.5)
        let item2 = Item(id: 2, count: 2, price: 12.75)
        let item3 = Item(id: 3, count: 1, price: 5)
        items = [item1, item2, item3]
    }

    override func tearDown() {
        items = []
        Cart.shared.empty()
    }

    func testAddingToCart() {
        Cart.shared.add(items[0])
        Cart.shared.add(items[1])
        Cart.shared.add(items[2])
        
        XCTAssertEqual(Cart.shared.totalCartItems, 4)
        
        XCTAssertEqual((19.5 + 2 * 12.75 + 5), Cart.shared.totalCartPrice)
    }
    
    func testEmptyCart() {
        XCTAssertTrue(Cart.shared.allItems.count == 0)
        
        Cart.shared.add(items[0])
        Cart.shared.empty()
        XCTAssertTrue(Cart.shared.allItems.count == 0)
    }

    func testFormattedPrice() {
        Cart.shared.add(items)
        let price = Cart.shared.formatterCartPrice
        print(price)
    }
    
    func testAddingItem() {
        self.measure {
            Cart.shared.add(items[0])
        }
    }
    
    func testMeasurePriceAndTotal() {
        self.measure {
            Cart.shared.add(items)
            _ = Cart.shared.totalCartItems
            _ = Cart.shared.totalCartPrice
            _ = Cart.shared.formatterCartPrice
        }
    }

}
