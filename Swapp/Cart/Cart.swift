//
//  Cart.swift
//  Swapp
//
//  Created by Hussein Jaber on 22/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import Foundation

protocol CartItem {
    var id: Int { get }
    var price: Double { get }
    var count: Int { get set }
    var description: String { get }
    var imageUrl: String { get set }
    var name: String { get }
}


final class Cart {
    
    private lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        formatter.alwaysShowsDecimalSeparator = false
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }()
    
    private var items: [CartItem] = []
    
    static let shared = Cart()
    
    private init() {}
    
    func add(_ item: CartItem) {
        items.append(item)
    }
    
    func add(_ items: [CartItem]) {
        self.items.append(contentsOf: items)
    }
    
    func remove(_ item: CartItem) {
        guard let index = items.firstIndex(where: { $0.id == item.id})
            else {
                return
        }
        items.remove(at: index)
    }
    
    func empty() {
        items.removeAll()
    }
    
    var totalCartItems: Int {
        return items.reduce(0, { $0 + $1.count })
    }
    
    var totalCartPrice: Double {
        return items.reduce(0, { $0 + (Double($1.count) * $1.price) })
    }
    
    var formatterCartPrice: String {
        return self.numberFormatter.string(from: .init(value: totalCartPrice))!
    }
    
    var allItems: [CartItem] {
        items
    }
}
