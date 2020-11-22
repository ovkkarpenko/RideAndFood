//
//  PromoCodesStrings.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 01.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

enum PromoCodesStrings {
    case title
    case enterPromoCode
    case promoCodesHistory
    case promoCodeIsInvalid
    case promoCodeHasExpired
    case promoCodeActivated
    case active
    case inactive
    case disclaimer
    case expiresIn
    case noPromoCodes
    
    func text() -> String {
        switch UserConfig.shared.settings.language {
        case .rus:
            return rusText()
        case .eng:
            return engText()
        }
    }
    
    private func rusText() -> String {
        switch self {
        case .title:
            return "Промокод"
        case .enterPromoCode:
            return "Ввести промокод"
        case .promoCodesHistory:
            return "История использования"
        case .promoCodeIsInvalid:
            return "Промокод недействителен"
        case .promoCodeHasExpired:
            return "Срок действия промокода истёк"
        case .promoCodeActivated:
            return "Промокод активирован"
        case .active:
            return "Активные"
        case .inactive:
            return "Неактивные"
        case .disclaimer:
            return "Обращаем ваше внимание, что скидки по промокодам на аналогичные сервисы не суммируются. На ближайший заказ сработает тот промокод, срок действия которого истекает раньше."
        case .expiresIn:
            return "Истекает через"
        case .noPromoCodes:
            return "Промокоды не найдены"
        }
    }
    
    private func engText() -> String {
        switch self {
        case .title:
            return "Promo code"
        case .enterPromoCode:
            return "Enter a promo code"
        case .promoCodesHistory:
            return "Usage history"
        case .promoCodeIsInvalid:
            return "The promo code is invalid"
        case .promoCodeHasExpired:
            return "The promo code has expired"
        case .promoCodeActivated:
            return "Promo code activated"
        case .active:
            return "Active"
        case .inactive:
            return "Inactive"
        case .disclaimer:
            return "Please note that discounts by promo codes for similar services do not add up. The promo code that expires earlier will be triggered for the next order."
        case .expiresIn:
            return "expires in"
        case .noPromoCodes:
            return "Promo codes not found"
        }
    }
}
