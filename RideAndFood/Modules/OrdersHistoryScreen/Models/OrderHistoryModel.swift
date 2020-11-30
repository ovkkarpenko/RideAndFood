//
//  OrderHistoryModel.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 26.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct OrderHistoryModel {
    
    var id: Int
    var from: String?
    var to: String?
    var distance: Int
    var price: Int
    var type: String
    var status: String
    var createdAt: Int
    var tariff: OrderHistoryTariffModel?
    var comment: OrderHistoryCommentModel?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case from = "from"
        case to = "to"
        case distance = "distance"
        case price = "price"
        case type = "type"
        case status = "status"
        case createdAt = "created_at"
        case comment = "comment"
        case tariff = "tariff"
    }
}

struct OrderHistoryCommentModel: Codable {
    var banknote: Int
}

struct OrderHistoryTariffModel: Codable {
    var id: Int
    var name: String
}

extension OrderHistoryModel: Codable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        from = try container.decodeIfPresent(String.self, forKey: .from)
        to = try container.decodeIfPresent(String.self, forKey: .to)
        distance = try container.decode(Int.self, forKey: .distance)
        price = try container.decode(Int.self, forKey: .price)
        type = try container.decode(String.self, forKey: .type)
        status = try container.decode(String.self, forKey: .status)
        createdAt = try container.decode(Int.self, forKey: .createdAt)
        tariff = try container.decodeIfPresent(OrderHistoryTariffModel.self, forKey: .tariff)
        comment = try container.decodeIfPresent(OrderHistoryCommentModel.self, forKey: .comment)
    }
}


