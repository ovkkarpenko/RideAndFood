//
//  CourierModel.swift
//  RideAndFood
//
//  Created by Laura Esaian on 29.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct CourierModel: Codable {
    var id: Int?
    var courier: [Courier]?
    
    struct Courier: Codable {
        var id: Int?
        var name: String?
        var phone: String?
    }
}
