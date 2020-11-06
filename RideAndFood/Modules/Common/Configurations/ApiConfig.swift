//
//  ApiConfig.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 29.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

enum ApiConfig<T> where T: Codable {
    
    case getSettings
    case saveSettings(data: T)
    
    case getProfile
    case saveProfile(data: T)
    
    case getPromotions
    case getPromotionDetails(Int)
    
    case registration(data: T)
    case confirm(data: T)
    
    case getPromoCodes
    case activatePromoCode(data: T)
    
    func createRequest() -> (method: HTTPMethod, url: String, data: T?) {
        let baseUrl = baseApiUrl
        let userId = UserConfig.shared.userId
        
        switch self {
        case .getSettings:
            return (.get, "\(baseUrl)/user/\(userId)/setting", nil)
        case .saveSettings(let data):
            return (.post, "\(baseUrl)/user/\(userId)/setting", data)
        case .getProfile:
            return (.get, "\(baseUrl)/user/\(userId)/profile", nil)
        case .saveProfile(let data):
            return (.put, "\(baseUrl)/user/\(userId)/profile", data)
        case .getPromotions:
            return (.get, "\(baseUrl)/user/\(userId)/promotions", nil)
        case .getPromotionDetails(let promotionId):
            return (.get, "\(baseUrl)/user/\(userId)/promotion/\(promotionId)", nil)
        case .registration(let data):
            return (.post, "\(baseUrl)/auth/registration", data)
        case .confirm(let data):
            return (.post, "\(baseUrl)/auth/confirm", data)
        case .getPromoCodes:
            return (.get, "\(baseUrl)/user/\(userId)/promo-codes", nil)
        case .activatePromoCode(let data):
            return (.post, "\(baseUrl)/user/\(userId)/promo-codes/activate", data)
        }
    }
}
