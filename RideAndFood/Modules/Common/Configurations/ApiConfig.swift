//
//  ApiConfig.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 29.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

enum ApiConfig<T> {
    
    case getSettings
    case saveSettings(data: T)
    
    case getProfile
    case saveProfile(data: T)
    
    func createRequest() -> (method: HTTPMethod, url: String, data: T?) {
        let userId = UserConfig.shared.userId
        
        switch self {
        case .getSettings:
            return (.get, "user/\(userId)/setting", nil)
        case .saveSettings(let data):
            return (.post, "user/\(userId)/setting", data)
        case .getProfile:
            return (.get, "user/\(userId)/profile", nil)
        case .saveProfile(let data):
            return (.put, "user/\(userId)/profile", data)
        }
    }
}
