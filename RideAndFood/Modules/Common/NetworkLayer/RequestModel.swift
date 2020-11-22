//
//  RequestModel.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 01.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class RequestModel<EncodeType: Codable> {
    var path: String = ""
    
    var method: HTTPMethod
    
    var parameters: [String : Any?]
    
    var headers: [String : String]
    
    var body: EncodeType?
    
    init(path: String, method: HTTPMethod, parameters: [String : Any?] = [:], headers: [String : String] = [:], body: EncodeType? = nil) {
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
                // Сделать общий конфигурационный файл с настройками подобного рода.
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                for header in headers {
                    request.addValue(header.value, forHTTPHeaderField: header.key)
                }
                
                switch method {
                case .post, .put:
                    do {
                        request.httpBody = try JSONEncoder().encode(body)
//                        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
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
    
    func upload(images: [UIImage]) -> URLRequest? {
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
                let boundary = generateBoundaryString()
                
                request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                for header in headers {
                    request.addValue(header.value, forHTTPHeaderField: header.key)
                }
                
                switch method {
                case .post, .put:
                    var httpBody = Data()
                    
                    if let body = body?.toDictionary {
                        for (key, value) in body {
                            httpBody.appendString(convertField(key: key, value: value as! String, using: boundary))
                        }
                    }
                    
                    for image in images {
                        let rand = arc4random()
                        if let imageData = image.jpegData(compressionQuality: .leastNormalMagnitude) {
                            httpBody.append(convertFileData(fileData: imageData, fieldName: "image_field", fileName: "image_\(rand).jpeg", mimeType: "image/jpeg", using: boundary))
                        }
                    }
                    
                    httpBody.appendString("--\(boundary)--")
                    
                    request.httpBody = httpBody
                default:
                    break
                }
                
                return request
            }
        }
        
        return nil
    }
    
    private func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    private func convertField(key: String, value: String, using boundary: String) -> String {
      var fieldString = "--\(boundary)\r\n"
      fieldString += "Content-Disposition: form-data; name=\"\(key)\"\r\n"
      fieldString += "\r\n"
      fieldString += "\(value)\r\n"

      return fieldString
    }
    
    private func convertFileData(fileData: Data, fieldName: String, fileName: String, mimeType: String, using boundary: String) -> Data {
      var data = Data()

      data.appendString("--\(boundary)\r\n")
      data.appendString("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n")
      data.appendString("Content-Type: \(mimeType)\r\n\r\n")
      data.append(fileData)
      data.appendString("\r\n")

      return data
    }
}
