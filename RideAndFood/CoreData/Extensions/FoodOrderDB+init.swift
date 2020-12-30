//
//  FoodOrderDB+init.swift
//  RideAndFood
//
//  Created by Laura Esaian on 29.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

extension FoodOrderDB {
    override func initialize(with properties: [String: Any]) {
        self.id = properties["id"] as? Int64 ?? 0
        self.courierName = properties["courierName"] as? String ?? ""
        self.courierNumber = properties["courierNumber"] as? String ?? ""
        self.fromAddress = properties["fromAddress"] as? String ?? ""
        self.toAddress = properties["toAddress"] as? String ?? ""
        self.time = properties["time"] as? Int64 ?? 0
        self.toAddressName = properties["toAddressName"] as? String ?? ""
    }
}
