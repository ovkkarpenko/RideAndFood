//
//  ShopDB+init.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 11.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import CoreData

extension ShopDB {
    override func initialize(with properties: [String: Any]) {
        self.shopId = properties["shopId"] as? Int16 ?? 0
        self.shopName = properties["shopName"] as? String
    }
}
