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
    case standart
    case premium
    case business
    case cars
    case aboutTariff
    
    func getString() -> String {
        switch UserConfig.shared.settings.language {
        case .rus:
            switch self {
            case .storyboardTitle:
                return "Тарифы"
            case .orderTaxiButton:
                return "Заказать такси"
            case .standart:
                return "Standart"
            case .premium:
                return "Premium"
            case .business:
                return "Business"
            case .cars:
                return "Автомобили: "
            case .aboutTariff:
                return "О тарифе"
            }
        case .eng:
            switch self {
            case .storyboardTitle:
                return "Tariffs"
            case .orderTaxiButton:
                return "Order a taxi"
            case .standart:
                return "Standart"
            case .premium:
                return "Premium"
            case .business:
                return "Business"
            case .cars:
                return "Cars: "
            case .aboutTariff:
                return "About tariff"
            }
        }
    }
}

enum TariffId: Int {
    case standart = 1
    case premium = 2
    case business = 3
}
