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
    
    func getSettings(userId: Int, completion: @escaping (Settings?, Error?) -> Void) {
        
        networkManager.makeRequest(
            httpMethod: .get,
            urlString: "user/\(userId)/setting",
            data: "") { (response: Response<Settings>?, error) in
            
            if let data = response?.data, error == nil { completion(data, nil) }
            else { completion(nil, error) }
        }
    }
    
    func saveSettings(_ settings: Settings, userId: Int, completion: ((Bool, Error?) -> Void)? = nil) {
        
        networkManager.makeRequest(
            httpMethod: .post,
            urlString: "user/\(userId)/setting",
            data: settings) { (response: Response<Settings>?, error) in
            
            if let _ = response?.data, error == nil { completion?(true, nil) }
            else { completion?(false, error) }
        }
    }
    
    func getProfile(_ userId: Int, completion: @escaping (Profile?, Error?) -> Void) {
        
        networkManager.makeRequest(
            httpMethod: .get,
            urlString: "user/\(userId)/profile",
            data: "") { (response: Response<Profile>?, error) in
            
            if let data = response?.data, error == nil { completion(data, nil) }
            else { completion(nil, error) }
        }
    }
    
    func saveProfile(_ settings: Profile, userId: Int, completion: ((Bool, Error?) -> Void)? = nil) {
        
        networkManager.makeRequest(
            httpMethod: .put,
            urlString: "user/\(userId)/profile",
            data: settings) { (response: Response<Profile>?, error) in
            
            if let _ = response?.data, error == nil { completion?(true, nil) }
            else { completion?(false, error) }
        }
    }
}
