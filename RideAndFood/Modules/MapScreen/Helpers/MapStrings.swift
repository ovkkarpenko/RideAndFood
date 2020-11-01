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
        switch language {
        case "rus":
            return rusText()
        case "eng":
            return engText()
        default:
            return rusText()
        }
    }
    
    private func rusText() -> String {
        switch self {
        case .taxi:
            return "Такси"
        case .food:
            return "Еда"
        }
    }
    
    private func engText() -> String {
        switch self {
        case .taxi:
            return "Taxi"
        case .food:
            return "Food"
        }
    }
}
