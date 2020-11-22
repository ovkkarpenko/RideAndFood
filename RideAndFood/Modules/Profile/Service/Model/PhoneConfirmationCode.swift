//
//  PhoneConfirmationCode.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 17.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct PhoneConfirmationCode: Codable {
    var actionId: Int?
    var code: Int?
    
    private enum CodingKeys: String, CodingKey {
        case actionId = "action_id"
        case code = "code"
    }
}
