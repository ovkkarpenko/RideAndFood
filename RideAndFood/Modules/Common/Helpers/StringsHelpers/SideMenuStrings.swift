//
//  SideMenuStrings.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 31.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

enum SideMenuStrings {
    case support
    case settings
    case paymentMethod
    case tariffs
    case promoCode
    case promotions
    case about(String)
    case title
    
    func text() -> String {
        switch UserConfig.shared.settings.language {
        case .rus:
            return rus()
        case .eng:
            return eng()
        }
    }
    
    func rus() -> String {
        switch self {
        case .support:
            return "Служба поддержки"
        case .settings:
            return "Настройки"
        case .paymentMethod:
            return "Способ оплаты"
        case .tariffs:
            return "Тарифы"
        case .promoCode:
            return "Промокод"
        case .promotions:
            return "Акции"
        case .about(let version):
            return "Об этом приложении (v.\(version))"
        case .title:
            return "Меню"
        }
    }
    
    func eng() -> String {
        switch self {
        case .support:
            return "Support"
        case .settings:
            return "Settings"
        case .paymentMethod:
            return "Payment method"
        case .tariffs:
            return "Tariffs"
        case .promoCode:
            return "Promo code"
        case .promotions:
            return "Promotions"
        case .about(let version):
            return "About this app (v.\(version))"
        case .title:
            return "Menu"
        }
    }
}
