//
//  PromotionsStrings.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 29.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

enum PromotionsStrings {
    case food
    case taxi
    case title
    case details
    case buttonFoodTitle
    case buttonTaxiTitle
    case promotionIsOver
    
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
        case .food:
            return "Еда"
        case .taxi:
            return "Такси"
        case .title:
            return "Акции"
        case .details:
            return "Подробнее"
        case .buttonFoodTitle:
            return "За покупками!"
        case .buttonTaxiTitle:
            return "В путь!"
        case .promotionIsOver:
            return "На данный момент акция не действительна.\nВоспользуйтесь ей в указанный временной промежуток"
        }
    }
    
    func eng() -> String {
        switch self {
        case .food:
            return "Food"
        case .taxi:
            return "Taxi"
        case .title:
            return "Promotions"
        case .details:
            return "Details"
        case .buttonFoodTitle:
            return "Go shopping!"
        case .buttonTaxiTitle:
            return "Let's hit the road!"
        case .promotionIsOver:
            return "At the moment, the promotion is not valid.\nUse it in the specified time period"
        }
    }
}
