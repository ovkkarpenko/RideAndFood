//
//  RequestErrorModel.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 01.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

enum ServerResponses: String {
    case allRight = "OK!"
    case notFound = "Ресурс не найден!"
    case bodyError = "Ошибка в теле запроса!"
    case unknown = "Неизвестная ошибка!"
}

class RequestErrorModel: Error {
    var message: String
    var response: ServerResponses = .unknown
    
    init (_ statusCode: Int) {
        let generalString = "Status code: \(statusCode). Message: "
        switch statusCode {
        case 200...299:
            response = .allRight
            message = generalString + ServerResponses.allRight.rawValue
        case 404:
            response = .notFound
            message = generalString + ServerResponses.notFound.rawValue
        case 422:
            response = .bodyError
            message = generalString + ServerResponses.bodyError.rawValue
        default:
            response = .unknown
            message = generalString + ServerResponses.unknown.rawValue
        }
    }
}
