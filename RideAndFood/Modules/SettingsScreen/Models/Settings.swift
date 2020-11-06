//
//  Settings.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 27.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct Settings {
    
    var language: Language
    var updateMobileNetwork: Bool
    var notificationDiscount: Bool
    var doNotCall: Bool
    
    enum CodingKeys: String, CodingKey {
        case language = "language"
        case updateMobileNetwork = "update_mobile_network"
        case notificationDiscount = "notification_discount"
        case doNotCall = "do_not_call"
    }
    
    init() {
        language = .rus
        updateMobileNetwork = false
        notificationDiscount = false
        doNotCall = false
    }
}

extension Settings: Codable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        language = try container.decode(Language.self, forKey: .language)
        updateMobileNetwork = try container.decode(Bool.self, forKey: .updateMobileNetwork)
        notificationDiscount = try container.decode(Bool.self, forKey: .notificationDiscount)
        doNotCall = try container.decode(Bool.self, forKey: .doNotCall)
    }
}
