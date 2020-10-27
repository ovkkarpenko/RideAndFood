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
    private let basePath = "auth/"
    
    // MARK: - Public methods
    
    func getCode(for phone: String, completion: @escaping (CodeModel?, Error?) -> Void) {
        networkManager.makeRequest(httpMethod: .post,
                                   urlString: "\(basePath)registration",
        data: PhoneModel(phone: phone)) { (response: Response<CodeModel>?, error) in
            
            guard let code = response?.data, error == nil else {
                return completion(nil, error)
            }
            
            completion(code, nil)
        }
    }
    
    func confirmCode(forPhone phone: String, code: String, completion: @escaping (UserDataModel?, Error?) -> Void) {
        networkManager.makeRequest(httpMethod: .post,
                                   urlString: "\(basePath)confirm",
        data: CodeConfirmationModel(phone: phone, code: code)) { (response: Response<UserDataModel>?, error) in
            guard let userData = response?.data, error == nil else {
                return completion(nil, error)
            }
            
            completion(userData, nil)
        }
    }
}
