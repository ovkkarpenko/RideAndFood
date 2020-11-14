//
//  TaxiOrderStrings.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 14.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

enum TaxiOrderStrings {
    case map
    case destinationPlaceholder
    
    func getString() -> String {
        switch UserConfig.shared.settings.language {
        case .rus:
            switch self {
            case .map:
                return "Карта →"
            case .destinationPlaceholder:
                return "Куда вы хотите поехать?"
            }
        case .eng:
            switch self {
            case .map:
                return "Map →"
            case .destinationPlaceholder:
                return "Where do you want to go?"
            }
        }
    }
}
