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
    var to: String
    var distance: Int
    var price: Int
    var type: String
    var status: String
    var createdAt: Int
    var comment: OrderHistoryCommentModel?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case to = "to"
        case distance = "distance"
        case price = "price"
        case type = "type"
        case status = "status"
        case createdAt = "created_at"
        case comment = "comment"
    }
}

struct OrderHistoryCommentModel: Codable {
    var banknote: Int
}

extension OrderHistoryModel: Codable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        to = try container.decode(String.self, forKey: .to)
        distance = try container.decode(Int.self, forKey: .distance)
        price = try container.decode(Int.self, forKey: .price)
        type = try container.decode(String.self, forKey: .type)
        status = try container.decode(String.self, forKey: .status)
        createdAt = try container.decode(Int.self, forKey: .createdAt)
        comment = try container.decodeIfPresent(OrderHistoryCommentModel.self, forKey: .comment)
    }
}


