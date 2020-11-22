//
//  RequestError.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 25.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

enum RequestError: Error {
    case invalidUrl
    case badRequest
    case serverError(message: String)
    case forbidden
}
