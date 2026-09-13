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

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false

    var name = ""
    var streetAddress = ""
    var zip = ""
    var city = ""

    var hasValidAdress: Bool {
        if name.isEmpty || streetAddress.isEmpty || zip.isEmpty || city.isEmpty {
            return false
        }
        return true
    }

}
