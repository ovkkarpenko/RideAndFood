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
    case errorTitle
    case errorText
    case wrongCode
    
    func text() -> String {
        switch UserConfig.shared.language {
        case .rus:
            return rusText()
        case .eng:
            return engText()
        }
    }
    
    private func rusText() -> String {
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
        case .errorTitle:
            return "Ошибка"
        case .errorText:
            return "Попробуйте ещё раз"
        case .wrongCode:
            return "Неверный код"
        }
    }
    
    private func engText() -> String {
        switch self {
        case .headerPhoneNumber:
            return "Enter your phone number"
        case .termsOfUse:
            return "I agree to the processing of personal data, I have read the Terms of use"
        case .termsOfUseLink:
            return "Terms of use"
        case .headerConfirmationCode:
            return "Confirmation code"
        case .codeDescriptionBegin:
            return "The confirmation code was sent to"
        case .codeDescriptionEnd:
            return ""
        case .resendCodeAfter:
            return "Resend after"
        case .resendCodeSeconds:
            return "seconds"
        case .resendCodeLink:
            return "Resend"
        case .errorTitle:
            return "Error"
        case .errorText:
            return "Try again"
        case .wrongCode:
            return "Wrong code"
        }
    }
}
