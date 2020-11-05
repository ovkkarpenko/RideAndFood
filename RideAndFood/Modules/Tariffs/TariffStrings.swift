//
//  TariffStrings.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 04.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

enum TariffStrings {
    case storyboardTitle
    case orderTaxiButton
    
    func getString() -> String {
        switch UserConfig.shared.settings.language {
        case .rus:
            switch self {
            case .storyboardTitle:
                return "Тарифы"
            case .orderTaxiButton:
                return "Заказать такси"
            }
        case .eng:
            switch self {
            case .storyboardTitle:
                return "Tariffs"
            case .orderTaxiButton:
                return "Order a taxi"
            }
        }
    }
}
