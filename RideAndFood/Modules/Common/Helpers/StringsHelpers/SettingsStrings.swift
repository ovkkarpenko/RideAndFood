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
        switch UserConfig.shared.language {
        case .rus:
            return "Русский"
        case .eng:
            return "English"
        }
    }
    
    func text() -> String {
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
}
