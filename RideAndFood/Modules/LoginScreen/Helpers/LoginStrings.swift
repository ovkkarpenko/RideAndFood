//
//  LoginStrings.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 23.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

enum LoginStrings {
    case headerPhoneNumber
    case termsOfUse
    case termsOfUseLink
    case headerConfirmationCode
    case codeDescriptionBegin
    case codeDescriptionEnd
    case resendCodeAfter
    case resendCodeSeconds
    case resendCodeLink
    
    func text() -> String {
        switch self {
        case .headerPhoneNumber:
            return "Укажите номер телефона"
        case .termsOfUse:
            return "Даю согласие на обработку персональных данных, с пользовательским соглашением ознакомлен"
        case .termsOfUseLink:
            return "пользовательским соглашением"
        case .headerConfirmationCode:
            return "Код подтверждения"
        case .codeDescriptionBegin:
            return "На номер"
        case .codeDescriptionEnd:
            return "отправлено смс с кодом."
        case .resendCodeAfter:
            return "Повторная отправка через"
        case .resendCodeSeconds:
            return "секунд"
        case .resendCodeLink:
            return "Отправить повторно"
        }
    }
}
