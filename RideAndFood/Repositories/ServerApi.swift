//
//  ServerApi.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 27.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

class ServerApi {
    
    static let shared = ServerApi()
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
