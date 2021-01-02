//
//  FoodOrderBodyModel.swift
//  RideAndFood
//
//  Created by Laura Esaian on 29.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct FoodOrderBodyModel: Codable {
    var to: String?
    var payment_card: Int?
    var payment_method: String?
    var promo_codes: [String]?
    var credit: Int?
    var comment: Comment?
    var products: [Int]?
    
    struct Comment: Codable {
        var banknote: Int?
    }
}
