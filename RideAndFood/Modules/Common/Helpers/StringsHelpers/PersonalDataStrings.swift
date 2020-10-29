//
//  PersonalDataStrings.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 29.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

enum PersonalDataStrings {
    case name
    
    func text() -> String {
        switch self {
        case .name:
            return "Имя"
        }
    }
}
