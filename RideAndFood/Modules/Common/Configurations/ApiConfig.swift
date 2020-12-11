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
    case getShopProducts(Int, Int)
    
    case getPromoCodes
    case activatePromoCode(data: T)
    
    case getPhones
    case addPhone(data: T)
    case confirmPhone(data: T)
    case changePhone(data: T)
    case deletePhone(data: T)
    
    case getPaymentsHistory
    
    case getOrdersHistory(String)
    
    case getCredits
    
    case orderTaxi(data: T)
    
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
        case .getShopProducts(let shopId, let subCategoryId):
            return (.get, "\(baseUrl)/user/\(userId)/shop/\(shopId)/products/\(subCategoryId)", nil)
        case .getPromoCodes:
            return (.get, "\(baseUrl)/user/\(userId)/promo-codes", nil)
        case .activatePromoCode(let data):
            return (.post, "\(baseUrl)/user/\(userId)/promo-codes/activate", data)
        case .getPhones:
            return (.get, "\(baseUrl)/user/\(userId)/phones", nil)
        case .addPhone(let data):
            return (.post, "\(baseUrl)/user/\(userId)/phones", data)
        case .confirmPhone(let data):
            let actionId = (data as? PhoneConfirmationCode)?.actionId ?? 0
            return (.post, "\(baseUrl)/user/\(userId)/phones/\(actionId)/confirm", data)
        case .changePhone(let data):
            let phoneId = (data as? Phone)?.id ?? 0
            return (.put, "\(baseUrl)/user/\(userId)/phones/\(phoneId)", data)
        case .deletePhone(let data):
            return (.delete, "\(baseUrl)/user/\(userId)/phones/\(data)", nil)
        case .getPaymentsHistory:
            return (.get, "\(baseUrl)/user/\(userId)/history/payments", nil)
        case .getOrdersHistory(let status):
            return (.get, "\(baseUrl)/user/\(userId)/history/order/all/status/\(status)", nil)
        case .getCredits:
            return (.get, "\(baseUrl)/user/\(userId)/credit", nil)
        case .orderTaxi(let data):
            return (.post, "\(baseUrl)/user/\(userId)/order/taxi", data)
        }
    }
}
