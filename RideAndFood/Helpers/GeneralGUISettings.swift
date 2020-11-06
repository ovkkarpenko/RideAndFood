//
//  GeneralGUISettings.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 21.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

//public let cornerRadius15: CGFloat = 15
//public let blueButtonColor = #colorLiteral(red: 0.2392156863, green: 0.231372549, blue: 1, alpha: 1)
//public let grayborderColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
//public let borderWidth: CGFloat = 1

public let generalCornerRaduis: CGFloat = 15

enum Colors {
    case buttonBlue
    case buttonWhite
    case buttonGreen
    case borderGray
    case disableGray
    case textGray
    case tariffGreen
    case tariffPurple
    case tariffGold
    case textBlack
    
    func getColor() -> UIColor {
        switch self {
        case .buttonBlue:
            return UIColor(hexString: "#3D3BFF")
        case .buttonWhite:
            return UIColor(hexString: "#FFFFFF")
        case .buttonGreen:
            return UIColor(hexString: "#34C759")
        case .borderGray:
            return UIColor(hexString: "#CCCCCC")
        case .disableGray:
            return UIColor(hexString: "#D0D0D0")
        case .textGray:
            return UIColor(hexString: "#8A8A8D")
        case .tariffGreen:
            return UIColor(hexString: "#A0E14C")
        case .tariffPurple:
            return UIColor(hexString: "#C442F2")
        case .tariffGold:
            return UIColor(hexString: "#D4BD80")
        case .textBlack:
            return UIColor(hexString: "#000000")
        }
    }
}

enum CustomButtonType {
    case blueButton
    case whiteButton
    case greenButton
}
