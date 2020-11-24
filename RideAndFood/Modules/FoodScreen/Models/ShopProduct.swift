//
//  ShopProduct.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 22.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct ShopProduct {
    
    var id: Int
    var name: String
    var icon: String = ""
    var price: Int?
    var weight: Int?
    var isCategory: Bool
    var isBackButton: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case icon = "icon"
        case price = "price"
        case weight = "weight"
        case isCategory = "is_category"
    }
}

extension ShopProduct: Codable {
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
        self.isCategory = true
        self.isBackButton = true
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        icon = try container.decode(String.self, forKey: .icon)
        isCategory = try container.decode(Bool.self, forKey: .isCategory)
        
        if container.contains(.price) {
            price = try container.decode(Int.self, forKey: .price)
        }
        
        if container.contains(.weight) {
            weight = try container.decode(Int.self, forKey: .weight)
        }
    }
}

