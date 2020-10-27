//
//  NetworkManager.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 25.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

protocol NetworkManager {
    
    func makeRequest<T: Codable, V: Codable>(httpMethod: HTTPMethod,
                                             urlString: String,
                                             data: T?,
                                             completion: @escaping ((V?, Error?) -> ()))
}
