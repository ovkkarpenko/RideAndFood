//
//  ServerConfig.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 29.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

let baseUrl = "https://skillbox.cc"
let oldBaseUrl = "http://85.119.145.2"
let baseApiUrl = "\(baseUrl)/api"
let supportPath = "/user/\(UserConfig.shared.userId)/support"
let tariffPath = "/user/\(UserConfig.shared.userId)/tariff"
let addressPath = "/user/\(UserConfig.shared.userId)/address"
let paymentCardPath = "/user/\(UserConfig.shared.userId)/payment-card/\(UserConfig.shared.paymentCardId)"
let orderFoodPath = "/user/\(UserConfig.shared.userId)/order/food"
