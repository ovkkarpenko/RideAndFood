//
//  ProfileStrings.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 09.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

enum ProfileStrings {
    case title
    case myAdresses
    case paymentsHistory
    case ordersHistory
    case paymentMethod
    case logOut
    case addPhoneNumber
    case changePhoneNumber
    case setAsDefault
    case isDefault
    case doLogOut
    
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
            return "Личный кабинет"
        case .myAdresses:
            return "Мои адреса"
        case .paymentsHistory:
            return "История платежей"
        case .ordersHistory:
            return "История заказов"
        case .paymentMethod:
            return "Способ оплаты"
        case .logOut:
            return "Выйти"
        case .addPhoneNumber:
            return "Добавить номер"
        case .changePhoneNumber:
            return "Изменить номер"
        case .setAsDefault:
            return "Назначить основным"
        case .isDefault:
            return "Основной"
        case .doLogOut:
            return "Выйти из приложения?"
        }
    }
    
    private func engText() -> String {
        switch self {
        case .title:
            return "My account"
        case .myAdresses:
            return "My addresses"
        case .paymentsHistory:
            return "Payments history"
        case .ordersHistory:
            return "Orders history"
        case .paymentMethod:
            return "Payment method"
        case .logOut:
            return "Log out"
        case .addPhoneNumber:
            return "Add number"
        case .changePhoneNumber:
            return "Change number"
        case .setAsDefault:
            return "Set as default"
        case .isDefault:
            return "Default"
        case .doLogOut:
            return "Log out of the app?"
        }
    }
}
