//
//  AddressModel.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 01.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct AddressModel: Codable {
    var id: Int?
    var name: String?
    var address: String?
    var commentDriver: String?
    var commentCourier: String?
    var flat: Int?
    var intercom: Int?
    var entrance: Int?
    var floor: Int?
    var destination: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case commentDriver = "comment_driver"
        case commentCourier = "comment_courier"
    }
}
