//
//  PaymentsHistoryService.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 24.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

protocol IPaymentsHistoryService {
    func getPayments(completion: @escaping (Result<[Payment], ServiceError>) -> Void)
}

class PaymentsHistoryService: IPaymentsHistoryService {
    
    // MARK: - Private properties
    
    private let networkManager: NetworkManager = BaseNetworkManager()
    
    // MARK: - IPaymentsHistoryService
    
    func getPayments(completion: @escaping (Result<[Payment], ServiceError>) -> Void) {
        let request = ApiConfig<[Payment]>.getPaymentsHistory.createRequest()
        networkManager.makeRequest(httpMethod: request.method,
                                   urlString: request.url,
                                   data: request.data) { (response: Response<[Payment]>?, error) in
                
            guard let responseData = response?.data else {
                completion(.failure(.someError))
                return
            }
            completion(.success(responseData))
        }
    }
}
