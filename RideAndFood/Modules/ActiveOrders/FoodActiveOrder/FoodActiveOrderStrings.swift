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
    
    func getString() -> String {
        switch UserConfig.shared.settings.language {
        case .rus:
            switch self {
            case .deliveryTime:
                return "Доставим через "
            }
        case .eng:
            switch self {
            case .deliveryTime:
                return "Will deliver via"
            }
        }
    }
}
