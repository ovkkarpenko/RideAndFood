//
//  Interactor.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 25.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

class LoginInteractor {
    
    // MARK: - Private properties
    
    private let networkManager: NetworkManager = BaseNetworkManager()
    
    // MARK: - Public methods
    
    func getCode(for phone: String, completion: @escaping (CodeModel?, Error?) -> Void) {
        let request = ApiConfig.registration(data: PhoneModel(phone: phone)).createRequest()
        networkManager.makeRequest(httpMethod: request.method,
                                   urlString: request.url,
                                   data: request.data) { (response: Response<CodeModel>?, error) in
            
            guard let code = response?.data, error == nil else {
                return completion(nil, error)
            }
            
            completion(code, nil)
        }
    }
    
    func confirmCode(forPhone phone: String, code: String, completion: @escaping (UserDataModel?, Error?) -> Void) {
        let request = ApiConfig.confirm(data: CodeConfirmationModel(phone: phone, code: code)).createRequest()
        
        networkManager.makeRequest(httpMethod: request.method,
                                   urlString: request.url,
                                   data: request.data) { (response: Response<UserDataModel>?, error) in
            guard let userData = response?.data, error == nil else {
                return completion(nil, error)
            }
            
            completion(userData, nil)
        }
    }
}
