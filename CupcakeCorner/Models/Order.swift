//
//  Order.swift
//  CupcakeCorner
//
//  Created by Yaroslav on 9/12/26.
//

import Foundation

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
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
    var cost: Decimal {
        var cost = type.cost * Decimal(quantity)

        if extraFrosting {
            cost += Decimal(quantity)
        }
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        return cost
    }
}
