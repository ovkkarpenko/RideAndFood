//
//  RequestModel.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 01.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class RequestModel {
    var path: String = ""

    var method: HTTPMethod

    var parameters: [String : Any?]

    var headers: [String : String]

    var body: [String : Any?]

    init(path: String, method: HTTPMethod, parameters: [String : Any?] = [:], headers: [String : String] = [:], body: [String : Any?] = [:]) {
        self.path = path
        self.parameters = parameters
        self.headers = headers
        self.method = method
        self.body = body
    }

    func urlRequest() -> URLRequest? {
        var endpoint: String = baseApiUrl + path

        for i in 0..<parameters.count {
            if let value = parameters[i].value as? String {
                if i == 0 {
                    endpoint.append("?\(parameters[i].key)=\(value)")
                } else {
                    endpoint.append("&\(parameters[i].key)=\(value)")
                }
            }
        }
        
        
        if let encodedString = endpoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let url = URL(string: encodedString) {
                var request: URLRequest = URLRequest(url: url)

                request.httpMethod = method.rawValue

                // На самом деле этого здесь не должно быть. Заголовки также вводятся пользователем.
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                for header in headers {
                    request.addValue(header.value, forHTTPHeaderField: header.key)
                }

                switch method {
                case .post, .put:
                    do {
                        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                    } catch let error {
                        print("Request body parse error: \(error.localizedDescription)")
                    }
                default:
                    break
                }

                return request
            }
        }

        return nil
    }
}
