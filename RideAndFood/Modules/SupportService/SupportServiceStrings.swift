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
        // if language == .rus {
        // }
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
        // else {
        // }
        switch self {
        case .supportServiceTitle:
            return "Support service"
        case .continueButton:
            return "Next"
        case .problemDescription:
            return "Describe your problem"
        case .photoAdderDescription:
            return "Attach images if necessary"
        case .sendButton:
            return "Send"
        case .takePhoto:
            return "Take a photo or video"
        case .mediaLibrary:
            return "Media"
        case .cancelButton:
            return "Cancel"
        case .great:
            return "Excellent!"
        case .allowAccess:
            return "Allow access"
        case .allowAccessMessage:
            return "Grant the app the necessary access rights in the settings"
        case .settings:
            return "Settings"
        case .requestSentMessage:
            return "Petition submitted"
        case .requestSentMessageDescription:
            return "Our Manager will contact you within an hour and try to solve your problem."
        }
    }
}
