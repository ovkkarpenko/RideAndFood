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
        }
    }
    
    private func engText() -> String {
        switch self {
        case .next:
            return "Next"
        }
    }
}
