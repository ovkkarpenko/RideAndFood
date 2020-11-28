//
//  Payment.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 24.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct Payment: Codable {
    let id: Int?
    let paid: Double?
    let method: String?
    let status: String?
    let order: Int?
    let paymentCard: PaymentCardShort?
    
    private enum CodingKeys: String, CodingKey {
        case paymentCard = "payment_card"
        case id = "id"
        case paid = "paid"
        case method = "method"
        case status = "status"
        case order = "order"
    }
}
