//
//  PromoCodesInteractor.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 03.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

class PromoCodesInteractor {
    
    // MARK: - Private properties
    
    private let networkManager: NetworkManager = BaseNetworkManager()
    
    // MARK: - Public methods
    
    func getPromoCodes(completion: @escaping ([PromoCode]?, String?) -> Void) {
        let request = ApiConfig<[PromoCode]>.getPromoCodes.createRequest()
        networkManager.makeRequest(httpMethod: request.method,
                                   urlString: request.url,
                                   data: request.data) { (response: Response<[PromoCode]>?, error) in
            
            guard let promoCodes = response?.data, error == nil else {
                return completion(nil, StringsHelper.error.text())
            }
            
            completion(promoCodes, nil)
        }
    }
    
    func activatePromoCode(code: String, completion: @escaping (ActivatePromoCodeResult?, String?) -> Void) {
        let request = ApiConfig.activatePromoCode(data: ActivatePromoCodeRequest(code: code)).createRequest()
        networkManager.makeRequest(httpMethod: request.method,
                                   urlString: request.url,
                                   data: request.data) { (response: Response<ActivatePromoCodeResult>?, error) in
            guard let response = response?.data, error == nil else {
                switch error as? RequestError {
                case .serverError(let message):
                    var errorDisplayText: String
                    switch message {
                    case "promo_code_not_found":
                        errorDisplayText = PromoCodesStrings.promoCodeIsInvalid.text()
                    case "promo_code_duplicate":
                        errorDisplayText = PromoCodesStrings.promoCodeHasExpired.text()
                    default:
                        errorDisplayText = StringsHelper.error.text()
                    }
                    return completion(nil, errorDisplayText)
                default:
                    return completion(nil, StringsHelper.error.text())
                }
            }
            
            completion(response, nil)
        }
    }
}
