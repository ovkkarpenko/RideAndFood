//
//  FontsHelper.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 23.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

enum FontHelper {
    case font12
    
    func font() -> UIFont? {
        switch self {
        case .font12:
            return .systemFont(ofSize: 12)
        }
    }
}
