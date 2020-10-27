//
//  Response.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 27.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct Response<T: Codable>: Codable {
    let data: T
}
