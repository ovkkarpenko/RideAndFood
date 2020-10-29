//
//  UserConfig.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 29.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct UserConfig {
    
    static let shared = UserConfig()
    
    private init() { }
    
    var userId: Int = 33
}
