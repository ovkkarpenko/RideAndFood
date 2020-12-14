//
//  CartViewModel.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 06.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct CartViewModel {
    let cartRows: [CartRowModel]
    let sum: Float
    let deliveryTimeInMinutes: Int
    let deliveryCost: Float
    let shopName: String?
    let backButtonTappedBlock: (() -> Void)?
}
