//
//  TaxiOrderDB+init.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 07.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import CoreData

extension TaxiOrderDB {
    override func initialize(with properties: [String: Any]) {
        self.id = properties["id"] as? Int64 ?? 0
        self.from = properties["from"] as? String ?? ""
        self.to = properties["to"] as? String ?? ""
        self.car = properties["car"] as? String ?? ""
        self.color = properties["color"] as? String ?? ""
        self.driver = properties["driver"] as? String ?? ""
        self.price = properties["price"] as? Float ?? 0
        self.carImage = properties["carImage"] as? String ?? ""
        self.tariffId = properties["tariffId"] as? Int16 ?? 1
        self.tariffName = properties["tariffName"] as? String ?? ""
    }
}
