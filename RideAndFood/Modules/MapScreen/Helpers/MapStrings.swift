//
//  MapStrings.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 27.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

enum MapStrings {
    case taxi
    case food
    
    func text() -> String {
        switch self {
        case .taxi:
            return "Такси"
        case .food:
            return "Еда"
        }
    }
}
