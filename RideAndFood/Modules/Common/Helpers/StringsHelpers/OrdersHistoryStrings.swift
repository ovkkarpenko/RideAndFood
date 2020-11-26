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
            return " / Услуги еды"
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
        }
    }
}
