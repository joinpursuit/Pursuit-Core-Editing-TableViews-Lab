//
//  ShoppingData.swift
//  labEditingTableViews
//
//  Created by Levi Davis on 8/16/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import Foundation

struct ShoppingItem {
    var name: String
    var price: Double
}

struct ShoppingItemFetchingClient {
    static func getShoppingItems() ->[ShoppingItem] {
        return [
            ShoppingItem(name: "Apple", price: 2.99),
            ShoppingItem(name: "Baseball Bat", price: 11.59),
            ShoppingItem(name: "Car", price: 20_000.99),
            ShoppingItem(name: "Donut", price: 1.19),
            ShoppingItem(name: "Egg", price: 0.19),
            ShoppingItem(name: "Fan", price: 8.99)
        ]
    }
}
