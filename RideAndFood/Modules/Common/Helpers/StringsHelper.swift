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
        switch self {
        case .next:
            return "Далее"
        }
    }
}
