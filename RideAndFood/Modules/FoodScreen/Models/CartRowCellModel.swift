//
//  CartRowCellModel.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 06.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct CartRowCellModel {
    let count: String
    let title: String
    let price: String
    
    init(model: CartRowModel) {
        count = "\(model.count)x"
        title = model.productName
        price = model.productPriceString
    }
}
