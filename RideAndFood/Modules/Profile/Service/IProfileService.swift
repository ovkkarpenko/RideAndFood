//
//  IProfileService.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 16.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

protocol IProfileService {
    func getPhones(completion: @escaping (Result<[Phone], ServiceError>) -> Void)
    func addPhone(phone: String, completion: @escaping (Result<PhoneConfirmationCode, ServiceError>) -> Void) 
    func deletePhone(id: Int, completion: @escaping (Result<[Phone], ServiceError>) -> Void)
    func confirmPhone(actionId: Int, code: Int, completion: @escaping (Result<[Phone], ServiceError>) -> Void)
    func changePhone(phone: Phone, completion: @escaping (Result<PhoneConfirmationCode, ServiceError>) -> Void)
    func logout(completion: @escaping () -> Void)
}
