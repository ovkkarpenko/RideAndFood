//
//  StringsHelper.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 23.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

enum StringsHelper {
    case next
    case alertErrorTitle
    case alertErrorDescription
    
    func text() -> String {
        switch UserConfig.shared.settings.language {
        case .rus:
            return rusText()
        case .eng:
            return engText()
        }
    }
    
    private func rusText() -> String {
        switch self {
        case .next:
            return "Далее"
        case .alertErrorTitle:
            return "Ошибка"
        case .alertErrorDescription:
            return "Пожалуйста, убедитесь, что вы правильно ввели данные."
        }
    }
    
    private func engText() -> String {
        switch self {
        case .next:
            return "Next"
        case .alertErrorTitle:
            return "Error"
        case .alertErrorDescription:
            return "Please ensure that you enter the data correctly."
        }
    }
}
