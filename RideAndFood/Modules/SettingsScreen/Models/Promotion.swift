//
//  Promotion.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 29.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

enum PromotionType: String {
    case food = "Food"
    case taxi = "Taxi"
}

struct Promotion: Codable {
    
    var id: Int
    var title: String
    var type: PromotionType.RawValue
    var media: [PromotionMedia]
}

struct PromotionMedia: Codable {
    
    var url: String
}
