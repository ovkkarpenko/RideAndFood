//
//  ConstantsHelper.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 23.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

enum ConstantsHelper {
    case baseAnimationDuration
    
    func value() -> Double {
        switch self {
        case .baseAnimationDuration:
            return 0.2
        }
    }
}
