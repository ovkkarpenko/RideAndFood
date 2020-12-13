//
//  FoodActiveOrderStrings.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 09.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation


enum FoodActiveOrderStrings {
    case deliveryTime
    case callCourier
    case cancelButton
    
    func getString() -> String {
        switch UserConfig.shared.settings.language {
        case .rus:
            switch self {
            case .deliveryTime:
                return "Доставим через "
            case .callCourier:
                return "Позвонить курьеру"
            case .cancelButton:
                return "Отменить заказ"
            }
        case .eng:
            switch self {
            case .deliveryTime:
                return "Will deliver via"
            case .callCourier:
                return "To call courier"
            case .cancelButton:
                return "Cancel order"
            }
        }
    }
}
