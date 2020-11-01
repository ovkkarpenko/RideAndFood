//
//  Networker.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 01.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class Networker {
    func makeRequest<T: Codable, U: Codable>(request: RequestModel<U>, images: [UIImage]?, completion: @escaping (T?, RequestErrorModel?) -> Void) {
        var urlRequest: URLRequest?
        urlRequest = images == nil ? request.urlRequest() : request.upload(images: images!)
        
        if let urlRequest = urlRequest {
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error as NSError? {
                    print("Error code: ", error.code, "Error message: ", error.localizedDescription)
                }
                
                guard let response = response as? HTTPURLResponse else { return }
                
                var responseModel = ResponseModel<T>()
                if let jsonData = data {
                    do {
                        let decoder = JSONDecoder()
                        responseModel = try decoder.decode(ResponseModel<T>.self, from: jsonData)
                    } catch let DecodingError.dataCorrupted(context) {
                        print(context)
                    } catch let DecodingError.keyNotFound(key, context) {
                        print("Key '\(key)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.valueNotFound(value, context) {
                        print("Value '\(value)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.typeMismatch(type, context)  {
                        print("Type '\(type)' mismatch:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch {
                        print("error: ", error)
                    }
                }
                
                DispatchQueue.main.async {
                    completion(responseModel.data, RequestErrorModel(response.statusCode))
                }
                
            }.resume()
        }
        
    }
}
