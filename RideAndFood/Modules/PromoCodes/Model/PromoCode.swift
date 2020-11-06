//
//  PromoCode.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 03.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct PromoCode {
    
    var id: Int
    var code: String
    var validity: Int
    var dateActivation: Date
    var used: Bool
    var description: String
    var shortDescription: String
    var sale: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case code = "code"
        case validity = "validity"
        case dateActivation = "date_activation"
        case used = "used"
        case description = "description"
        case shortDescription = "short_description"
        case sale = "sale"
    }
}

extension PromoCode: Codable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        code = try container.decode(String.self, forKey: .code)
        validity = try container.decode(Int.self, forKey: .validity)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        dateActivation = formatter.date(from: try container.decode(String.self, forKey: .dateActivation)) ?? Date()
        used = try container.decode(Bool.self, forKey: .used)
        description = try container.decode(String.self, forKey: .description)
        shortDescription = try container.decode(String.self, forKey: .shortDescription)
        sale = try container.decode(Int.self, forKey: .sale)
    }
}
