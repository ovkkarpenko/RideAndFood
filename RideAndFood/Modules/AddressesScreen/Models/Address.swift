//
//  Address.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 12.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct Address {
    
    var id: Int?
    var name: String = ""
    var address: String = ""
    var commentDriver: String?
    var commentCourier: String?
    var flat: Int = 0
    var intercom: Int = 0
    var entrance: Int = 0
    var floor: Int = 0
    var destination: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case address = "address"
        case commentDriver = "comment_driver"
        case commentCourier = "comment_courier"
        case flat = "flat"
        case intercom = "intercom"
        case entrance = "entrance"
        case floor = "floor"
        case destination = "destination"
    }
}

extension Address: Codable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        address = try container.decode(String.self, forKey: .address)
        commentDriver = try container.decodeIfPresent(String.self, forKey: .commentDriver)
        commentCourier = try container.decodeIfPresent(String.self, forKey: .commentCourier)
        flat = try container.decodeIfPresent(Int.self, forKey: .flat) ?? 0
        intercom = try container.decodeIfPresent(Int.self, forKey: .intercom) ?? 0
        entrance = try container.decodeIfPresent(Int.self, forKey: .entrance) ?? 0
        floor = try container.decodeIfPresent(Int.self, forKey: .floor) ?? 0
        destination = try container.decodeIfPresent(Bool.self, forKey: .destination) ?? false
    }
}
