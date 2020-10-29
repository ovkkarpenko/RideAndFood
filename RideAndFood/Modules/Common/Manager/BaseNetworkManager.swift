//
//  BaseNetworkManager.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 25.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

class BaseNetworkManager: NetworkManager {
    
    // MARK: - Private fields
    
    private let baseUrl = URL(string: "http://85.119.145.2/api/")
    
    // MARK: - NetworkManager
    
    func makeRequest<T: Codable, V: Codable>(httpMethod: HTTPMethod,
                                             urlString: String,
                                             data: T?,
                                             completion: @escaping ((V?, Error?) -> ())) {
        
        guard let url = URL(string: urlString, relativeTo: baseUrl) else {
            completion(nil, RequestError.invalidUrl)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let data = data, httpMethod != .get {
            request.httpBody = try? JSONEncoder().encode(data)
        }
        
        DispatchQueue.global().async {
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data,
                      let result = try? JSONDecoder().decode(V.self, from: data),
                      error == nil
                else {
                    if let response = response as? HTTPURLResponse,
                       response.statusCode != 200 {
                        return completion(nil, RequestError.badRequest)
                    }
                    
                    return completion(nil, error)
                }
                
                if let response = response as? HTTPURLResponse,
                   response.statusCode != 200 {
                    return completion(nil, RequestError.badRequest)
                }
                
                return completion(result, nil)
            }.resume()
        }
    }
}
