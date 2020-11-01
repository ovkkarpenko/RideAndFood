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
    
    init (_ statusCode: Int) {
        let generalString = "Status code: \(statusCode). Message: "
        switch statusCode {
        case 200...299:
            message = generalString + ServerResponses.allRight.rawValue
        case 404:
            message = generalString + ServerResponses.notFound.rawValue
        case 422:
            message = generalString + ServerResponses.bodyError.rawValue
        default:
            message = generalString + ServerResponses.unknown.rawValue
        }
    }
}
