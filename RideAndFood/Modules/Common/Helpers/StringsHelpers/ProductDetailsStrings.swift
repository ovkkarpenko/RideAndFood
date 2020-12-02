//
//  ProductDetailsStrings.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 29.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

enum ProductDetailsStrings {
    case composition
    case producer
    case country
    case addToCard
    
    func text() -> String {
        switch UserConfig.shared.settings.language {
        case .rus:
            return rus()
        case .eng:
            return eng()
        }
    }
    
    private func rus() -> String {
        switch self {
        case .composition:
            return "Состав"
        case .producer:
            return "Производитель"
        case .country:
            return "Страна"
        case .addToCard:
            return "В корзину"
        }
    }
    
    private func eng() -> String {
        switch self {
        case .composition:
            return "Composition"
        case .producer:
            return "Producer"
        case .country:
            return "Country"
        case .addToCard:
            return "Add to card"
        }
    }
}
