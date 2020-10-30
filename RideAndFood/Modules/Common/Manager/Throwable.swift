//
//  Throwable.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 30.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

public struct Throwable<T: Decodable>: Decodable {
    
    public let result: Result<T, Error>

    public init(from decoder: Decoder) throws {
        let catching = { try T(from: decoder) }
        result = Result(catching: catching )
    }
}
