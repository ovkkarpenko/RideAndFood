//
//  ServerApi.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 27.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

class ServerApi {
    
    private let networkManager: NetworkManager = BaseNetworkManager()
    
    func getSettings(userId: Int, completion: @escaping (Settings?, Error?) -> Void) {
        
        networkManager.makeRequest(
            httpMethod: .get,
            urlString: "user/\(userId)/setting",
            data: "") { (response: Response<Settings>?, error) in
            
            guard let data = response?.data, error == nil else { return completion(nil, error) }
            completion(data, nil)
        }
    }
}
