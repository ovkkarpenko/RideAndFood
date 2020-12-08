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
    case promoCodeActivatedTitle
    case promoCodeActivatedDescription
    
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
        case .promoCodeActivatedTitle:
            return "Промокод активирован"
        case .promoCodeActivatedDescription:
            return "По этому промокоду для вас действует скидка 10% на поездку по тарифу Premium."
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
        case .promoCodeActivatedTitle:
            return "Promo code activated"
        case .promoCodeActivatedDescription:
            return "With this promo code, you get a 10% discount on your Premium fare."
        }
    }
}
