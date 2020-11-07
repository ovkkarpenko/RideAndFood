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
    case newOrderButtonTitle
    case detailsButtonTitle
    case congratulationsAlertTitle
    case pointsFullTitle(String)
    case pointsTitle(String)
    case congratulationsFullTitle(String)
    case congratulationsPointsTitle(String)
    case congratulationsDescription
    case paymentPointsDetailsTitle
    case paymentPointsDetailsStartCollect
    case paymentPointsDetailsDescription
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
        case .paymentPointsDetailsStartCollect:
            return "Начать копить баллы"
        case .paymentPointsDetailsTitle:
            return "Пользуйтесь сервисом – копите баллы!"
        case .congratulationsAlertTitle:
            return "Поздравляем!"
        case .pointsFullTitle(let points):
            return "У вас \(points) баллов"
        case .pointsTitle(let points):
            return "\(points) баллов"
        case .congratulationsFullTitle(let points):
            return "У вас \(points) бонусных баллов"
        case .congratulationsPointsTitle(let points):
            return "\(points) бонусных баллов"
        case .congratulationsDescription:
            return "Количество баллов всегда можно посмотреть в данном разделе, либо при оплате заказа"
        case .newOrderButtonTitle:
            return "Новый заказ"
        case .detailsButtonTitle:
            return "Подробнее"
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
        case .paymentPointsDetailsDescription:
            return "Программа лояльности для пользователей сервисами приложения «Ride & Drive». Программа предназначена для накопления баллов пользователем при оплате любым способом. 1 балл приравнивается к 1 рублю. При использовании сервиса «Такси» баллы начисляются согласно ставке 10% от суммы заказа свыше 800 рублей единовременно. При использовании сервиса «Еда» баллы начисляются согласно ставке 5% от суммы заказа свыше 1000 рублей единовременно. Использование баллов дает право пользователю на комбинированную оплату заказа. При оплате баллами заказа сервиса «Такси» минимальная сумма заказа – 200 рублей, максимальная оплата баллами – 50 баллов.  При оплате баллами заказа сервиса «Еда» минимальная сумма заказа – 300 рублей, максимальная оплата баллами – 50 баллов."
        }
    }
    
    func eng() -> String {
        switch self {
        case .paymentPointsDetailsStartCollect:
            return "Start collecting points"
        case .paymentPointsDetailsTitle:
            return "Use the service - collect points!"
        case .congratulationsAlertTitle:
            return "Congratulations!"
        case .pointsFullTitle(let points):
            return "You have \(points) points"
        case .pointsTitle(let points):
            return "\(points) points"
        case .congratulationsFullTitle(let points):
            return "You have \(points) bonus points"
        case .congratulationsPointsTitle(let points):
            return "\(points) bonus points"
        case .congratulationsDescription:
            return "The number of points can always be viewed in this section, or when paying for an order"
        case .newOrderButtonTitle:
            return "New order"
        case .detailsButtonTitle:
            return "Details"
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
        case .paymentPointsDetailsDescription:
            return "Loyalty program for users of the services of the \"Ride & Drive\" application. The program is intended for the accumulation of points by the user when paying in any way. 1 point is equal to 1 ruble. When using the Taxi service, points are awarded at the rate of 10% of the order amount over 800 rubles at a time. When using the \"Food\" service, points are awarded at a rate of 5% of the order amount over 1000 rubles at a time. The use of points entitles the user to a combined order payment. When paying with points for ordering the Taxi service, the minimum order amount is 200 rubles, the maximum payment with points is 50 points. When paying with points for ordering the \"Food\" service, the minimum order amount is 300 rubles, the maximum payment with points is 50 points."
        }
    }
}
