//
//  ShopDetails.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 21.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct ShopDetails: Codable {
    
    var id: Int
    var name: String
    var categories: [ShopCategory]
    var schedule: String
    var description: String
    var address: String
    var icon: String
}

struct ShopCategory: Codable {
    
    var id: Int
    var name: String
    var icon: String
}
