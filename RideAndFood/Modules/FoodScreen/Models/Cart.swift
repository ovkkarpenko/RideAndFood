//
//  Cart.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 07.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct Cart {
    let rows: [CartRowModel]
    let shopId: Int?
    let shopName: String?
    var sum: Float {
        rows.reduce(0, { result, row in
            result + row.sum
        })
    }
}
