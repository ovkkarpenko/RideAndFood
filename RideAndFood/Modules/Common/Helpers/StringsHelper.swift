//
//  StringsHelper.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 23.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

enum StringsHelper {
    case next
    case confirm
    case great
    case error
    case tryAgain
    case hour
    case hours
    case hoursSecond
    case day
    case days
    case daysSecond
    
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
        case .next:
            return "Далее"
        case .confirm:
            return "Подтвердить"
        case .great:
            return "Отлично!"
        case .error:
            return "Ошибка"
        case .tryAgain:
            return "Пожалуйста, попробуйте позже"
        case .hour:
            return "час"
        case .hours:
            return "часов"
        case .hoursSecond:
            return "часа"
        case .day:
            return "день"
        case .days:
            return "дней"
        case .daysSecond:
            return "дня"
        }
    }
    
    private func engText() -> String {
        switch self {
        case .next:
            return "Next"
        case .confirm:
            return "Confirm"
        case .great:
            return "Great!"
        case .error:
            return "Error"
        case .tryAgain:
            return "Please, try again later"
        case .hour:
            return "hour"
        case .hours:
            return "hours"
        case .hoursSecond:
            return "hours"
        case .day:
            return "day"
        case .days:
            return "days"
        case .daysSecond:
            return "days"
        }
    }
}
