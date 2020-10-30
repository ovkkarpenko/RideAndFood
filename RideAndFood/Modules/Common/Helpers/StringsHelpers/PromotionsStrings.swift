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
        switch self {
        case .food:
            return "Food"
        case .taxi:
            return "Taxi"
        case .title:
            return "Акции"
        case .details:
            return "Подробнее"
        case .buttonFoodTitle:
            return "За покупками!"
        case .buttonTaxiTitle:
            return "В путь!"
        case .promotionIsOver:
            return "На данный момент акция недействительна.\nВоспользуйтесь ей в указанный временной промежуток"
        }
    }
}
