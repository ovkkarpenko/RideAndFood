//
//  ShopProduct.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 22.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct ShopProduct: Codable {
    
    var id: Int
    var name: String
    var icon: String
    var price: Int?
    var weight: Int?
}
