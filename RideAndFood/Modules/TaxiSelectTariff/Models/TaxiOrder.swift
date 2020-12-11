//
//  TaxiOrder.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 08.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct TaxiOrder {
    
    var tariff: Int
    var from: String
    var to: String
    var paymentCard: Int
    var paymentMethod: String
    var promoCodes: [String] = []
    var credit: Int
    
    enum CodingKeys: String, CodingKey {
        case tariff = "tariff"
        case from = "from"
        case to = "to"
        case paymentCard = "payment_card"
        case paymentMethod = "payment_method"
        case promoCodes = "promo_codes"
        case credit = "credit"
    }
}

extension TaxiOrder: Codable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        tariff = try container.decode(Int.self, forKey: .tariff)
        from = try container.decode(String.self, forKey: .from)
        to = try container.decode(String.self, forKey: .to)
        paymentCard = try container.decode(Int.self, forKey: .paymentCard)
        paymentMethod = try container.decode(String.self, forKey: .paymentMethod)
        promoCodes = try container.decode([String].self, forKey: .promoCodes)
        credit = try container.decode(Int.self, forKey: .credit)
    }
}
