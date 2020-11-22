//
//  ServerApi.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 27.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

class ServerApi {
    
    public static let shared = ServerApi()
    private let networkManager: NetworkManager = BaseNetworkManager()
    
    private init() { }
    
    func getSettings(completion: ((Settings?, Error?) -> ())?) {
        sendRequest(apiConfig: ApiConfig<Settings>.getSettings, completion: completion)
    }
    
    func saveSettings(_ settings: Settings, completion: ((Settings?, Error?) -> ())? = nil) {
        sendRequest(apiConfig: ApiConfig<Settings>.saveSettings(data: settings), completion: completion)
    }
    
    func getProfile(completion: ((Profile?, Error?) -> ())?) {
        sendRequest(apiConfig: ApiConfig<Profile>.getProfile, completion: completion)
    }
    
    func saveProfile(_ profile: Profile, completion: ((Profile?, Error?) -> ())? = nil) {
        sendRequest(apiConfig: ApiConfig<Profile>.saveProfile(data: profile), completion: completion)
    }
    
    func getPromotions(completion: (([Promotion]?, Error?) -> ())?) {
        sendRequest(apiConfig: ApiConfig<[Promotion]>.getPromotions, completion: completion)
    }
    
    func getPromotionDetails(id promotionId: Int, completion: ((PromotionDetails?, Error?) -> ())?) {
        sendRequest(apiConfig: ApiConfig<PromotionDetails>.getPromotionDetails(promotionId), completion: completion)
    }
    
    func savePaymentCard(_ card: PaymentCard, completion: ((PaymentCardDetails?, Error?) -> ())?) {
        sendRequest(apiConfig: ApiConfig<PaymentCard>.savePaymentCard(data: card), completion: completion)
    }
    
    func paymentCardApproved(id cardId: Int, completion: ((String?, Error?) -> ())?) {
        sendRequest(apiConfig: ApiConfig<String>.paymentCardApproved(cardId: cardId), completion: completion)
    }

    func getPaymentCardDetails(id cardId: Int, completion: ((PaymentCardDetails?, Error?) -> ())?) {
        sendRequest(apiConfig: ApiConfig<PaymentCardDetails>.getPaymentCardDetails(cardId: cardId), completion: completion)
    }

    func getPaymentCards(completion: (([PaymentCard]?, Error?) -> ())?) {
        sendRequest(apiConfig: ApiConfig<[PaymentCard]>.getPaymentCards, completion: completion)
    }
    
    func getAddresses(completion: (([Address]?, Error?) -> ())?) {
        sendRequest(apiConfig: ApiConfig<[Address]>.getAddresses, completion: completion)
    }
    
    func saveAddress(_ address: Address, completion: (([Address]?, Error?) -> ())?) {
        sendRequest(apiConfig: ApiConfig<Address>.saveAddress(data: address), completion: completion)
    }
    
    func updateAddress(_ address: Address, completion: ((Address?, Error?) -> ())?) {
        sendRequest(apiConfig: ApiConfig<Address>.updateAddress(data: address, addressId: address.id ?? 0), completion: completion)
    }
    
    func deleteAddress(_ address: Address, completion: (([Address]?, Error?) -> ())?) {
        sendRequest(apiConfig: ApiConfig<Address>.removeAddress(addressId: address.id ?? 0), completion: completion)
    }
    
    func getShops(completion: (([FoodShop]?, Error?) -> ())?) {
        sendRequest(apiConfig: ApiConfig<[FoodShop]>.getShops, completion: completion)
    }
    
    func getShopDetails(shopId: Int, completion: ((ShopDetails?, Error?) -> ())?) {
        sendRequest(apiConfig: ApiConfig<ShopDetails>.getShopDetails(shopId), completion: completion)
    }
    
    func getShopSubCategory(shopId: Int, completion: (([FoodShop]?, Error?) -> ())?) {
        sendRequest(apiConfig: ApiConfig<[FoodShop]>.getShopSubCategory(shopId), completion: completion)
    }
    
    private func sendRequest<T: Codable, V: Codable>(apiConfig: ApiConfig<T>, completion: ((V?, Error?) -> ())?) {
        let request = apiConfig.createRequest()
        
        networkManager.makeRequest(
            httpMethod: request.method,
            urlString: request.url,
            data: request.data) { (response: Response<V>?, error) in
            
            if let data = response?.data {
                completion?(data, error)
            } else {
                completion?(nil, error)
            }
        }
    }
}
