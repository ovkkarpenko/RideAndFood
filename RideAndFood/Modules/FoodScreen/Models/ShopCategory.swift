//
//  ShopCategory.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 21.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct ShopCategory: Codable {
    
    var id: Int
    var name: String
    var categories: [ShopCategories]
}

struct ShopCategories: Codable {
    
    var id: Int
    var name: String
    var icon: String
}
