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

enum SettingsPersonalDataStrings {
    case name
    case termsOfUse
    case termsOfUseLink1
    case termsOfUseLink2
    case nameCellTitle
    case emailCellTitle
    case confirm
    
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
        case .name:
            return "Имя"
        case .termsOfUse:
            return "Указывая свои данные, вы подтверждаете, что ознакомились с пользовательским соглашением, а так же с политикой конфиденциальности"
        case .termsOfUseLink1:
            return "пользовательским соглашением"
        case .termsOfUseLink2:
            return "политикой конфиденциальности"
        case .nameCellTitle:
            return "Как вас зовут?"
        case .emailCellTitle:
            return "Укажите ваш e-mail"
        case .confirm:
            return "Подтвердить"
        }
    }
    
    func eng() -> String {
        switch self {
        case .name:
            return "Name"
        case .termsOfUse:
            return "By entering your data, you confirm that you have read the user agreement, as well as the privacy policy"
        case .termsOfUseLink1:
            return "user agreement"
        case .termsOfUseLink2:
            return "privacy policy"
        case .nameCellTitle:
            return "What is your name?"
        case .emailCellTitle:
            return "Enter your e-mail"
        case .confirm:
            return "Confirm"
        }
    }
}
