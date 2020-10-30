//
//  ServerConfig.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 29.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct ServerConfig {
    
    static let shared = ServerConfig()
    
    private init() { }
    
    let baseUrl = "http://85.119.145.2"
    let baseApiUrl = "http://85.119.145.2/api"
}
