//
//  PaymentCard.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 05.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct PaymentCard {
    
    var id: Int?
    var number: String
    var expiryDate: String
    var cvc: String?
    var status: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case number = "number"
        case expiryDate = "expiry_date"
        case cvc = "cvc"
        case status = "status"
    }
}

extension PaymentCard: Codable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        number = try container.decode(String.self, forKey: .number)
        expiryDate = try container.decode(String.self, forKey: .expiryDate)
        status = try container.decode(String.self, forKey: .status)
        
        if container.contains(.cvc) {
            cvc = try container.decode(String.self, forKey: .cvc)
        }
    }
}
