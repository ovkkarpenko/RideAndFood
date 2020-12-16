//
//  ColorHelper.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 23.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

enum ColorHelper {
    
    case background
    case primary
    case primaryText
    case secondaryText
    case primaryButtonText
    case disabledButton
    case controlBackground
    case shadow
    case secondaryBackground
    case error
    case success
    case transparentGray
    case transparentBlack
    case transparentWhite
    case controlSecondaryBackground
    case notification
    case green
    
    func color() -> UIColor? {
        switch self {
        case .background:
            return .white
        case .primary:
            return UIColor(named: "Primary")
        case .primaryText:
            return .black
        case .secondaryText:
            return UIColor(named: "SecondaryText")
        case .primaryButtonText:
            return .white
        case .disabledButton:
            return UIColor(named: "DisabledButton")
        case .controlBackground:
            return UIColor(named: "ControlBackground")
        case .shadow:
            return .black
        case .secondaryBackground:
            return UIColor(named: "SecondaryBackground")
        case .error:
            return UIColor(named: "Error")
        case .success:
            return UIColor(named: "Success")
        case .transparentGray:
            return UIColor(named: "TransparentGray")
        case .transparentBlack:
            return UIColor(named: "TransparentBlack")
        case .transparentWhite:
            return UIColor(named: "TransparentWhite")
        case .controlSecondaryBackground:
            return UIColor(named: "ControllSecondaryBackground")
        case .notification:
            return UIColor(named: "Notification")
        case .green:
            return UIColor(named: "Green")
        }
    }
}
