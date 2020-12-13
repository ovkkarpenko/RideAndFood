//
//  ActiveTaxiOrderStrings.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 09.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

enum ActiveTaxiOrderStrings {
    case deliveryTime
    case addDelivery
    case reportProblem
    
    func getString() -> String {
        switch UserConfig.shared.settings.language {
        case .rus:
            switch self {
            case .deliveryTime:
                return "Оставшееся время в пути "
            case .addDelivery:
                return "Добавить доставку"
            case .reportProblem:
                return "Сообщить о проблеме"
            }
        case .eng:
            switch self {
            case .deliveryTime:
                return "The remaining travel time"
            case .addDelivery:
                return "Add delivery"
            case .reportProblem:
                return "Report a problem"
            }
        }
    }
}
