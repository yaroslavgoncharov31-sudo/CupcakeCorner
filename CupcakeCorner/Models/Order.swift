//
//  Order.swift
//  CupcakeCorner
//
//  Created by Yaroslav on 9/12/26.
//

import Foundation

@Observable
class Order {
    var type: CupcakeType = .chocolate
    var quantity = 3

    var specialRequestEnabled = false
    var extraFrosting = false
    var addSprinkles = false
}
