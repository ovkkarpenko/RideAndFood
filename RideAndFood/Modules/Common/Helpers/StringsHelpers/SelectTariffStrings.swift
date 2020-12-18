//
//  SelectTariffStrings.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 05.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

enum SelectTariffStrings {
    case order
    case promoCodeTitle
    case pointsTitle
    case promoCodeActivatedTitle
    case promoCodeActivatedDescription
    case spendAllPoints
    case otherQuantity
    case lookingForDriver
    case pointsCountTitle
    case reasonTitle
    case reason1
    case reason2
    case reason3
    case reason4
    case youCencelOrderTitle
    case youCencelOrderDescription
    case problem
    case anotherOrder
    case cencelTitle
    case continueSearchOrderTitle
    case continueSearchOrderControllerTitle
    case continueSearchOrderDescription
    case good
    
    func text() -> String {
        switch UserConfig.shared.settings.language {
        case .rus:
            return rus()
        case .eng:
            return eng()
        }
    }
    
    private func rus() -> String {
        switch self {
        case .order:
            return "Заказать"
        case .promoCodeTitle:
            return "Промокод"
        case .pointsTitle:
            return "Баллы"
        case .promoCodeActivatedTitle:
            return "Промокод активирован"
        case .promoCodeActivatedDescription:
            return "По этому промокоду для вас действует скидка 10% на поездку по тарифу Premium."
        case .spendAllPoints:
            return "Потратить все баллы сразу"
        case .otherQuantity:
            return "Другое количество"
        case .lookingForDriver:
            return "Ищем подходящий вариант"
        case .pointsCountTitle:
            return "Введите количество баллов"
        case .reasonTitle:
            return "Причина отмены"
        case .reason1:
            return "Поменялись планы"
        case .reason2:
            return "Заказ совершён по ошибке"
        case .reason3:
            return "Долгое ожидание заказа"
        case .reason4:
            return "Без указания причины"
        case .youCencelOrderTitle:
            return "Вы отменили заказ"
        case .youCencelOrderDescription:
            return "Вы всегда можете совершить другой заказ, либо сообщить нам о возникшей проблеме."
        case .anotherOrder:
            return "Другой заказ"
        case .problem:
            return "Сообщить о проблеме"
        case .cencelTitle:
            return "Отмена заказа"
        case .continueSearchOrderTitle:
            return "Мы продолжим поиск"
        case .continueSearchOrderDescription:
            return "Как только появится подходящий для вас вариант, вы получите уведомление."
        case .good:
            return "Отлично!"
        case .continueSearchOrderControllerTitle:
            return "Поиск в фоновом режиме"
        }
    }
    
    private func eng() -> String {
        switch self {
        case .order:
            return "Order"
        case .promoCodeTitle:
            return "Promocode"
        case .pointsTitle:
            return "Points"
        case .promoCodeActivatedTitle:
            return "Promo code activated"
        case .promoCodeActivatedDescription:
            return "With this promo code, you get a 10% discount on your Premium fare."
        case .spendAllPoints:
            return "Spend all points at once"
        case .otherQuantity:
            return "Other quantity"
        case .lookingForDriver:
            return "We are looking for a suitable option"
        case .pointsCountTitle:
            return "Enter the number of points"
        case .reasonTitle:
            return "Reason for cancellation"
        case .reason1:
            return "Changed plans"
        case .reason2:
            return "Order was made by mistake"
        case .reason3:
            return "Долгое ожидание заказа"
        case .reason4:
            return "Long waiting time for order"
        case .youCencelOrderTitle:
            return "You canceled your order"
        case .youCencelOrderDescription:
            return "You can always make another order, or inform us about the problem."
        case .anotherOrder:
            return "Other order"
        case .problem:
            return "Report a problem"
        case .cencelTitle:
            return "Order cancellation"
        case .continueSearchOrderTitle:
            return "We will continue to search"
        case .continueSearchOrderDescription:
            return "As soon as a suitable option appears for you, you will receive a notification."
        case .good:
            return "Fine!"
        case .continueSearchOrderControllerTitle:
            return "Search in the background"
        }
    }
}
