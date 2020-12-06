//
//  SelectTariffStrings.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 05.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

enum SelectTariffStrings {
    case order
    case promoCodeTitle
    case pointsTitle
    
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
        case .order:
            return "Заказать"
        case .promoCodeTitle:
            return "Промокод"
        case .pointsTitle:
            return "Баллы"
        }
    }
    
    private func eng() -> String {
        switch self {
        case .order:
            return "Order"
        case .promoCodeTitle:
            return "Promocode"
        case .pointsTitle:
            return "Points"
        }
    }
}
