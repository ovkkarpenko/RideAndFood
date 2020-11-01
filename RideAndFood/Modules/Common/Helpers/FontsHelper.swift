//
//  FontsHelper.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 23.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

enum FontHelper {
    case regular12
    case semibold15
    
    func font() -> UIFont? {
        switch self {
        case .regular12:
            return .systemFont(ofSize: 12)
        case .semibold15:
            return .systemFont(ofSize: 15, weight: .semibold)
        }
    }
}
