//
//  PaymentStrings.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 06.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

enum PaymentStrings {
    case paymentTitle
    case bindCardTitle
    case bindCardNumberTitle
    case bindCardDateTitle
    case bindCardCVVTitle
    case cash
    case card
    case addCard
    case bindCard
    case bindCardButtonTitle
    case bindCardAlert(String)
    case confirmButtonTitle
    case celncelButtonTitle
    case points
    case applePay
    
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
        case .confirmButtonTitle:
            return "Подтвердить"
        case .celncelButtonTitle:
            return "Отмена"
        case .bindCardNumberTitle:
            return "Номер карты"
        case .bindCardDateTitle:
            return "Срок"
        case .bindCardCVVTitle:
            return "CVV"
        case .paymentTitle:
            return "Способ оплаты"
        case .bindCardTitle:
            return "Новая карта"
        case .points:
            return "Баллы"
        case .card:
            return "Банковская карта"
        case .addCard:
            return "Добавить карту"
        case .bindCard:
            return "Привязать карту"
        case .bindCardButtonTitle:
            return "Подтверждение"
        case .bindCardAlert(let card):
            return "Для подтверждения платёжеспособности с карты\n**** \(card) будет списан 1 руб. Сумма будет возвращена сразу после подтверждения из банка."
        case .cash:
            return "Наличные"
        case .applePay:
            return "Apple Pay"
        }
    }
    
    func eng() -> String {
        switch self {
        case .confirmButtonTitle:
            return "Confirm"
        case .celncelButtonTitle:
            return "Cencel"
        case .bindCardNumberTitle:
            return "Card number"
        case .bindCardDateTitle:
            return "Date"
        case .bindCardCVVTitle:
            return "CVV"
        case .paymentTitle:
            return "Payment method"
        case .bindCardTitle:
            return "New card"
        case .points:
            return "Points"
        case .card:
            return "Credit card"
        case .addCard:
            return "Add credit card"
        case .bindCard:
            return "Bind credit card"
        case .bindCardButtonTitle:
            return "Confirmation"
        case .bindCardAlert(let card):
            return "To confirm the ability to pay, 1 rub will be debited from the card **** \(card). The amount will be returned immediately after confirmation from the bank."
        case .cash:
            return "Cash"
        case .applePay:
            return "Apple Pay"
        }
    }
}
