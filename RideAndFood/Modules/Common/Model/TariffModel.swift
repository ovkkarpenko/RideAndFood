//
//  TariffModel.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 04.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct TariffModel: Codable {
    var id: Int?
    var name: String?
    var cars: String?
    var description: String?
    var icon: String?
    var advantages: [Advantage?]?
    
    struct Advantage: Codable {
        var name: String?
        var icon: String?
    }
}
