//
//  OrdersHistoryStrings.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 26.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

enum OrdersHistoryStrings {
    case title
    case emptyTitle
    case taxiService
    case foodService
    case taxi
    case food
    case rub
    case completedButton
    case cenceledButton
    case cancellationReason
    case paymentId(Int)
    case fromLabel
    case toLabel
    case driverLabel
    case carLabel
    case carNumberLabel
    case travelTimeLabel
    case minutes(Int)
    case shopLabel
    case courierLabel
    case orderList
    
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
        case .title:
            return "История заказов"
        case .emptyTitle:
            return "Здесь пока пусто..."
        case .taxiService:
            return " / Услуги такси"
        case .foodService:
            return " / Доставка еды"
        case .taxi:
            return "Такси"
        case .food:
            return "Еда"
        case .rub:
            return "руб"
        case .completedButton:
            return "Завершённые"
        case .cenceledButton:
            return "Отменённые"
        case .cancellationReason:
            return "Причина отмены: "
        case .paymentId(let id):
            return "Платёж № \(id)"
        case .fromLabel:
            return "От:"
        case .toLabel:
            return "До:"
        case .driverLabel:
            return "Водитель:"
        case .carLabel:
            return "Автомобиль:"
        case .carNumberLabel:
            return "Номер:"
        case .travelTimeLabel:
            return "Время в пути:"
        case .minutes(let value):
            return "\(value) минут"
        case .shopLabel:
            return "Магазин:"
        case .courierLabel:
            return "Курьер:"
        case .orderList:
            return "Состав заказа:"
        }
    }
    
    private func eng() -> String {
        switch self {
        case .title:
            return "Orders history"
        case .emptyTitle:
            return "It's empty here for now..."
        case .taxiService:
            return " / Taxi service"
        case .foodService:
            return " / Food service"
        case .taxi:
            return "Taxi"
        case .food:
            return "Food"
        case .rub:
            return "rub"
        case .completedButton:
            return "Completed"
        case .cenceledButton:
            return "Canceled"
        case .cancellationReason:
            return "Reason for cancellation: "
        case .paymentId(let id):
            return "Payment # \(id)"
        case .fromLabel:
            return "From:"
        case .toLabel:
            return "To:"
        case .driverLabel:
            return "Driver:"
        case .carLabel:
            return "Car:"
        case .carNumberLabel:
            return "Car number:"
        case .travelTimeLabel:
            return "Travel time:"
        case .minutes(let value):
            return "\(value) minutes"
        case .shopLabel:
            return "Shop:"
        case .courierLabel:
            return "Courier:"
        case .orderList:
            return "Order list:"
        }
    }
}
