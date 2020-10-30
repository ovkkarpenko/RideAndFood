//
//  PromotionDetails.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 30.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct PromotionDetails {
    
    var id: Int
    var title: String
    var dateTo: String?
    var timeTo: String?
    var description: String
    var type: PromotionType
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case dateTo = "date_to"
        case timeTo = "time_to"
        case type = "type"
    }
}

extension PromotionDetails: Codable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        dateTo = try container.decode(String?.self, forKey: .dateTo)
        timeTo = try container.decode(String?.self, forKey: .timeTo)
        type = try container.decode(PromotionType.self, forKey: .type)
    }
}
