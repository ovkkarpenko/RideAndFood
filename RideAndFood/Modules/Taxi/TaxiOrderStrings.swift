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
    case next
    case confirm
    case currentAddressDetailPlaceholder
    case destinationAddressDetailPlaceholder
    
    func getString() -> String {
        switch UserConfig.shared.settings.language {
        case .rus:
            switch self {
            case .map:
                return "Карта →"
            case .destinationPlaceholder:
                return "Куда вы хотите поехать?"
            case .next:
                return  "Далее"
            case .confirm:
                return "Подтвердить"
            case .currentAddressDetailPlaceholder:
                return "Уточните, как до вас добраться"
            case .destinationAddressDetailPlaceholder:
                return "Уточните, куда едем"
            }
        case .eng:
            switch self {
            case .map:
                return "Map →"
            case .destinationPlaceholder:
                return "Where do you want to go?"
            case .next:
                return "Next"
            case .confirm:
                return "Confirm"
            case .currentAddressDetailPlaceholder:
                return "Specify how to get to you"
            case .destinationAddressDetailPlaceholder:
                return "Specify where we are going"
            }
        }
    }
}
