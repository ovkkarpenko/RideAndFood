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
    
    private let baseUrl = URL(string: baseApiUrl)
    
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
            URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
                guard let data = data, error == nil else {
                    if !(self?.isSuccess(response: response) ?? false) {
                        return completion(nil, RequestError.badRequest)
                    }
                    
                    return completion(nil, error)
                }
                
                guard let result = try? JSONDecoder().decode(V.self, from: data) else {
                    if let responseError = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                        return completion(nil, RequestError.serverError(responseError.error))
                    }
                    
                    return completion(nil, RequestError.badRequest)
                }
                
                if !(self?.isSuccess(response: response) ?? false) {
                    return completion(nil, RequestError.badRequest)
                }
                
                return completion(result, nil)
            }.resume()
        }
    }
    
    // MARK: - Private methods
    
    private func isSuccess(response: URLResponse?) -> Bool {
        if let response = response as? HTTPURLResponse {
            return (200 ... 299) ~= response.statusCode
        }
        return false
    }
}
