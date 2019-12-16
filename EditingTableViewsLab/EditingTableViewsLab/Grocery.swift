//
//  Grocery.swift
//  EditingTableViewsLab
//
//  Created by Ahad Islam on 12/15/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import Foundation

struct Grocery {
    
    enum Status: Int, Comparable, CustomStringConvertible {
        
        case notPurchased
        case purchased
        
        var description: String {
            switch self {
            case .notPurchased:
                return "Not Purchased"
            case .purchased:
                return "Purchased"
            }
        }
        
        static func < (lhs: Grocery.Status, rhs: Grocery.Status) -> Bool {
            lhs == .notPurchased && rhs == .purchased ? true : false
        }
    }
    
    let status: Status
    let item: String
    
    static let getGroceries = [Grocery(status: .purchased, item: "Eggs"),
                               Grocery(status: .purchased, item: "Beef"),
                               Grocery(status: .purchased, item: "Vanilla"),
                               Grocery(status: .notPurchased, item: "Water"),
                               Grocery(status: .notPurchased, item: "Ice Cream")]
}
