//
//  PaymentCard.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 05.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct PaymentCard {
    
    var number: String
    var expiryDate: String
    var cvc: String
    
    enum CodingKeys: String, CodingKey {
        case number = "number"
        case expiryDate = "expiry_date"
        case cvc = "cvc"
    }
}

extension PaymentCard: Codable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        number = try container.decode(String.self, forKey: .number)
        expiryDate = try container.decode(String.self, forKey: .expiryDate)
        cvc = try container.decode(String.self, forKey: .cvc)
    }
}
