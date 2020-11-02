//
//  SupportServiceStrings.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 26.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

enum SupportServiceString {
    case supportServiceTitle
    case continueButton
    case problemDescription
    case photoAdderDescription
    case sendButton
    case takePhoto
    case mediaLibrary
    case cancelButton
    case great
    case allowAccess
    case allowAccessMessage
    case settings
    case requestSentMessage
    case requestSentMessageDescription
    
    func getString() -> String {
        switch self {
        case .supportServiceTitle:
            return "Служба поддержки"
        case .continueButton:
            return "Далее"
        case .problemDescription:
            return "Опишите возникшую проблему"
        case .photoAdderDescription:
            return "При необходимости прикрепите изображения"
        case .sendButton:
            return "Отпарвить"
        case .takePhoto:
            return "Снять фото или видео"
        case .mediaLibrary:
            return "Медиатека"
        case .cancelButton:
            return "Отмена"
        case .great:
            return "Отлично!"
        case .allowAccess:
            return "Разрешите доступ"
        case .allowAccessMessage:
            return "Предоставьте приложению необходимые права доступа в настройках"
        case .settings:
            return "Настройки"
        case .requestSentMessage:
            return "Обращение отправлено"
        case .requestSentMessageDescription:
            return "В течении часа с вами свяжется наш менеджер и постарается решить вашу проблему."
        }
    }
}
