//
//  TaxiStrings.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 16.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

enum TaxiStrings {
    case driver
    case pickupTime
    
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
        case .driver:
            return "Водитель"
        case .pickupTime:
            return "Время подачи"
        }
    }
    
    private func eng() -> String {
        switch self {
        case .driver:
            return "Driver"
        case .pickupTime:
            return "Pick-up time"
        }
    }
}
