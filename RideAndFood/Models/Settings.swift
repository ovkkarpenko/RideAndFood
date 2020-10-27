//
//  Settings.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 27.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct Settings {
    
    var language: String
    var updateMobileNetwork: Bool
    var notificationDiscount: Bool
    var doNotCall: Bool
    
    enum CodingKeys: String, CodingKey {
        case language = "language"
        case updateMobileNetwork = "update_mobile_network"
        case notificationDiscount = "notification_discount"
        case doNotCall = "do_not_call"
    }
}

extension Settings: Codable {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
    
        language = try values.decode(String.self, forKey: .language)
        updateMobileNetwork = try values.decode(Bool.self, forKey: .updateMobileNetwork)
        notificationDiscount = try values.decode(Bool.self, forKey: .notificationDiscount)
        doNotCall = try values.decode(Bool.self, forKey: .doNotCall)
    }
}
