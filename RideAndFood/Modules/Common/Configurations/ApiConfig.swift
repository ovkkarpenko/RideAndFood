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
    
    case savePaymentCard(data: T)
    case paymentCardApproved(cardId: Int)
    case getPaymentCardDetails(cardId: Int)
    case getPaymentCards
    
    case saveAddress(data: T)
    case getAddresses
    case removeAddress(addressId: Int)
    case updateAddress(data: T, addressId: Int)
    
    case getShops
    case getShopDetails(Int)
    case getShopSubCategory(Int)
    
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
        case .savePaymentCard(let data):
            return (.post, "\(baseUrl)/user/\(userId)/payment-card", data)
        case .paymentCardApproved(let cardId):
            return (.post, "\(baseUrl)/user/\(userId)/payment-card/\(cardId)/approved", nil)
        case .getPaymentCardDetails(let cardId):
            return (.get, "\(baseUrl)/user/\(userId)/payment-card/\(cardId)", nil)
        case .getPaymentCards:
            return (.get, "\(baseUrl)/user/\(userId)/payment-cards", nil)
        case .saveAddress(let data):
            return (.post, "\(baseUrl)/user/\(userId)/address", data)
        case .removeAddress(let id):
            return (.delete, "\(baseUrl)/user/\(userId)/address/\(id)", nil)
        case .updateAddress(let data, let id):
            return (.put, "\(baseUrl)/user/\(userId)/address/\(id)", data)
        case .getAddresses:
            return (.get, "\(baseUrl)/user/\(userId)/address", nil)
        case .getShops:
            return (.get, "\(baseUrl)/user/\(userId)/shops", nil)
        case .getShopDetails(let shopId):
            return (.get, "\(baseUrl)/user/\(userId)/shop/\(shopId)", nil)
        case .getShopSubCategory(let shopId):
            return (.get, "\(baseUrl)/user/\(userId)/shop/\(shopId)/products", nil)
        }
    }
}
