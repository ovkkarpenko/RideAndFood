//
//  Promotion.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 29.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

enum PromotionType: String, Codable {
    case food
    case taxi
}

struct Promotion {
    
    var id: Int
    var title: String
    var dateTo: String
    var type: PromotionType
    var media: [PromotionMedia]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case dateTo = "date_to"
        case type = "type"
        case media = "media"
    }
}

struct PromotionMedia: Codable {
    
    var url: String
}

extension Promotion: Codable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let moviesThrowables = try container.decode([Throwable<PromotionMedia>].self, forKey: .media)
        
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        dateTo = try container.decode(String.self, forKey: .dateTo)
        type = try container.decode(PromotionType.self, forKey: .type)
        media = moviesThrowables.compactMap { return try? $0.result.get() }
    }
}
