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
}
