//
//  PersonalDataStrings.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 29.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

enum PersonalDataStrings {
    case name
    case termsOfUse
    case termsOfUseLink1
    case termsOfUseLink2
    
    func text() -> String {
        switch self {
        case .name:
            return "Имя"
        case .termsOfUse:
            return "Указывая свои данные, вы подтверждаете, что ознакомились с пользовательским соглашением, а так же с политикой конфиденциальности"
        case .termsOfUseLink1:
            return "пользовательским соглашением"
        case .termsOfUseLink2:
            return "политикой конфиденциальности"
        }
    }
}
