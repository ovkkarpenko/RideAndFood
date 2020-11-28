//
//  PaymentsHistoryStrings.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 23.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

enum PaymentsHistoryStrings {
    case title
    case taxi
    case food
    case rub
    case search
    case sendEmail
    case payment
    case description
    
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
            return "История платежей"
        case .taxi:
            return "Услуги такси"
        case .food:
            return "Доставка еды"
        case .rub:
            return "руб"
        case .search:
            return "Найти платёж"
        case .sendEmail:
            return "Отправить на mail"
        case .payment:
            return "Платёж"
        case .description:
            return "Разнообразный и богатый опыт говорит нам, что повышение уровня гражданского сознания способствует повышению качества существующих финансовых и административных условий. Предварительные выводы неутешительны: понимание сути ресурсосберегающих технологий предопределяет высокую востребованность дальнейших направлений развития. "
        }
    }
    private func engText() -> String {
        switch self {
        case .title:
            return "Payments history"
        case .taxi:
            return "Taxi service"
        case .food:
            return "Food delivery"
        case .rub:
            return "rub"
        case .search:
            return "Search payment"
        case .sendEmail:
            return "Sent to mail"
        case .payment:
            return "Payment"
        case .description:
            return "A diverse and rich experience tells us that raising the level of civic awareness contributes to improving the quality of existing financial and administrative conditions. Preliminary conclusions are disappointing: understanding the essence of resource-saving technologies determines the high demand for further development directions."
        }
    }
}
