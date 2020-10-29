//
//  PromotionsStrings.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 29.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

enum PromotionsStrings {
    case title
    case details
    
    func text() -> String {
        switch self {
        case .title:
            return "Акции"
        case .details:
            return "Подробнее"
        }
    }
}
