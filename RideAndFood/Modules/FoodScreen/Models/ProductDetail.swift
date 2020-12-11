//
//  ProductDetail.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 29.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct ProductDetail: Codable {
    let id: Int
    let name: String
    let price: Float
    let sale: Int
    let hit: Bool
    let composition: String
    let weight: String
    let unit: String
    let producing: String
    let image: String
    let country: String
}
