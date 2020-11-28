//
//  ProfileService.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 16.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

class ProfileService: IProfileService {
    
    // MARK: - Private properties
    
    private let networkManager: NetworkManager = BaseNetworkManager()
    
    // MARK: - IAccountService
    
    func getPhones(completion: @escaping (Result<[Phone], ServiceError>) -> Void) {
        let request = ApiConfig<[Phone]>.getPhones.createRequest()
        networkManager.makeRequest(httpMethod: request.method,
                                   urlString: request.url,
                                   data: request.data) { (response: Response<[Phone]>?, error) in
            	
            guard let responseData = response?.data else {
                completion(.failure(.someError))
                return
            }
            completion(.success(responseData))
        }
    }
    
    func addPhone(phone: String, completion: @escaping (Result<PhoneConfirmationCode, ServiceError>) -> Void) {
        let request = ApiConfig<Phone>.addPhone(data: Phone(id: 0, phone: phone, main: false)).createRequest()
        networkManager.makeRequest(httpMethod: request.method,
                                   urlString: request.url,
                                   data: request.data) { (response: Response<PhoneConfirmationCode>?, error) in

            guard let model = response?.data else {
                completion(.failure(.someError))
                return
            }
            completion(.success(model))
        }
    }
    
    func confirmPhone(actionId: Int, code: Int, completion: @escaping (Result<[Phone], ServiceError>) -> Void) {
        let request = ApiConfig<PhoneConfirmationCode>.confirmPhone(data: .init(actionId: actionId, code: code)).createRequest()
        networkManager.makeRequest(httpMethod: request.method,
                                   urlString: request.url,
                                   data: request.data) { (response: Response<[Phone]>?, error) in
            
            guard let responseData = response?.data else {
                completion(.failure(.someError))
                return
            }
            completion(.success(responseData))
        }
    }
    
    func changePhone(phone: Phone, completion: @escaping (Result<PhoneConfirmationCode, ServiceError>) -> Void) {
        let request = ApiConfig<Phone>.changePhone(data: phone).createRequest()
        networkManager.makeRequest(httpMethod: request.method,
                                   urlString: request.url,
                                   data: request.data) { (response: Response<PhoneConfirmationCode>?, error) in
            
            guard let responseData = response?.data else {
                completion(.failure(.someError))
                return
            }
            completion(.success(responseData))
        }
    }
    
    func deletePhone(id: Int, completion: @escaping (Result<[Phone], ServiceError>) -> Void) {
        let request = ApiConfig<Int>.deletePhone(data: id).createRequest()
        networkManager.makeRequest(httpMethod: request.method,
                                   urlString: request.url,
                                   data: request.data) { (response: Response<[Phone]>?, error) in
            
            guard let responseData = response?.data else {
                completion(.failure(.someError))
                return
            }
            completion(.success(responseData))
        }
    }
    
    func logout(completion: @escaping () -> Void) {
        UserConfig.shared.userId = 0
        completion()
    }
}

// MARK: - Error

enum ServiceError: Error {
    case someError
}
