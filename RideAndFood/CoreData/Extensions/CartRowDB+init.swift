//
//  CartRowDB+init.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 02.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import CoreData

extension CartRowDB {
    override func initialize(with properties: [String: Any]) {
        self.productId = properties["productId"] as? Int16 ?? 0
        self.productName = properties["productName"] as? String
        self.productPrice = properties["productPrice"] as? Float ?? 0
        self.count = properties["count"] as? Int16 ?? 0
    }
}
