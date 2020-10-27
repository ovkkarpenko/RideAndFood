//
//  TermsOfUseStrings.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 23.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

enum TermsOfUseStrings {
    case title
    
    func text() -> String {
        switch self {
        case .title:
            return "Пользовательское соглашение"
        }
    }
}
