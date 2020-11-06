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
    
    func getSettings(completion: ((Settings?) -> ())?) {
        sendRequest(apiConfig: ApiConfig<Settings>.getSettings, completion: completion)
    }
    
    func saveSettings(_ settings: Settings, completion: ((Settings?) -> ())? = nil) {
        sendRequest(apiConfig: ApiConfig<Settings>.saveSettings(data: settings), completion: completion)
    }
    
    func getProfile(completion: ((Profile?) -> ())?) {
        sendRequest(apiConfig: ApiConfig<Profile>.getProfile, completion: completion)
    }
    
    func saveProfile(_ profile: Profile, completion: ((Profile?) -> ())? = nil) {
        sendRequest(apiConfig: ApiConfig<Profile>.saveProfile(data: profile), completion: completion)
    }
    
    func getPromotions(completion: (([Promotion]?) -> ())?) {
        sendRequest(apiConfig: ApiConfig<[Promotion]>.getPromotions, completion: completion)
    }
    
    func getPromotionDetails(id promotionId: Int, completion: ((PromotionDetails?) -> ())?) {
        sendRequest(apiConfig: ApiConfig<PromotionDetails>.getPromotionDetails(promotionId), completion: completion)
    }
    
    func savePaymentCard(_ card: PaymentCard, completion: ((PaymentCardDetails?) -> ())?) {
        sendRequest(apiConfig: ApiConfig<PaymentCard>.savePaymentCard(data: card), completion: completion)
    }
    
    func paymentCardApproved(id cardId: Int, completion: ((Bool?) -> ())?) {
        let request = ApiConfig<String>.paymentCardApproved(cardId: cardId).createRequest()
        
        networkManager.makeRequest(
            httpMethod: request.method,
            urlString: request.url,
            data: request.data) { ( response: String?, error) in
            
            completion?(error == nil)
        }
    }

    func getPaymentCardDetails(id cardId: Int, completion: ((PaymentCardDetails?) -> ())?) {
        sendRequest(apiConfig: ApiConfig<PaymentCardDetails>.getPaymentCardDetails(cardId: cardId), completion: completion)
    }

    func getPaymentCards(completion: (([PaymentCard]?) -> ())?) {
        sendRequest(apiConfig: ApiConfig<[PaymentCard]>.getPaymentCards, completion: completion)
    }
    
    private func sendRequest<T: Codable, V: Codable>(apiConfig: ApiConfig<T>, completion: ((V?) -> ())?) {
        let request = apiConfig.createRequest()
        
        networkManager.makeRequest(
            httpMethod: request.method,
            urlString: request.url,
            data: request.data) { (response: Response<V>?, error) in
            
            if let data = response?.data, error == nil {
                completion?(data)
            } else {
                completion?(nil)
            }
        }
    }
}
