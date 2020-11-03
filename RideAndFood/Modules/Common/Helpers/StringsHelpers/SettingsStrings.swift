//
//  SettingsStrings.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 29.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

enum SettingsStrings {
    case title
    case language
    case personalData
    case pushNotification
    case stockNotifications
    case availableShares
    case automaticUpdatingGeo
    case refreshNetwork
    
    func language() -> String {
        switch UserConfig.shared.settings.language {
        case .rus:
            return "Русский"
        case .eng:
            return "English"
        }
    }
    
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
        case .title:
            return "Настройки"
        case .language:
            return "Язык"
        case .personalData:
            return "Персональные данные"
        case .pushNotification:
            return "Push-уведомление вместо звонка"
        case .stockNotifications:
            return "Уведомления об акциях"
        case .availableShares:
            return "Доступные акции"
        case .automaticUpdatingGeo:
            return "Автоматическое обновление данных геолокации"
        case .refreshNetwork:
            return "Обновлять по сотовой сети"
        }
    }
    
    func eng() -> String {
        switch self {
        case .title:
            return "Settings"
        case .language:
            return "Language"
        case .personalData:
            return "Personal data"
        case .pushNotification:
            return "Push notification instead of ringing"
        case .stockNotifications:
            return "Promotions notifications"
        case .availableShares:
            return "Available promotions"
        case .automaticUpdatingGeo:
            return "Auto update geolocation"
        case .refreshNetwork:
            return "Refresh over cellular network"
        }
    }
}
