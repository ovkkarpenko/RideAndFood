//
//  ExtensionsOfSwiftTypes.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 01.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

extension Dictionary {
    public subscript(i: Int) -> (key: Key, value: Value) {
        get {
            return self[index(startIndex, offsetBy: i)]
        }
    }
}

extension Data {
    mutating func appendString(_ string: String) {
    if let data = string.data(using: .utf8) {
      self.append(data)
    }
  }
}

extension Encodable {
  var toDictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}
