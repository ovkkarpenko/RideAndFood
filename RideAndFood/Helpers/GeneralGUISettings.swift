//
//  GeneralGUISettings.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 21.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

public let generalCornerRaduis: CGFloat = 15
public let generalAnimationDuration: TimeInterval = 0.25
public let generalDelay: TimeInterval = 0.1

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
    case shadowColor
    case locationOrange
    case tapIndicatorGray
    case tapIndicatorOnDark
    case tableViewBorderGray
    case backgroundGray
    case carNumberGray
    case yellow
    case errorRed
    
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
        case .shadowColor:
            return UIColor(hexString: "#000000", alpha: 0.1)
        case .locationOrange:
            return UIColor(hexString: "#FB8E50")
        case .tapIndicatorGray:
            return UIColor(hexString: "#000000", alpha: 0.5)
        case .tapIndicatorOnDark:
            return UIColor(hexString: "#FFFFFF", alpha: 0.5)
        case .tableViewBorderGray:
            return UIColor(hexString: "#C6C6C8")
        case .backgroundGray:
            return UIColor(hexString: "#F0F0F0")
        case .carNumberGray:
            return UIColor(hexString: "#F3F3F3")
        case .yellow:
            return UIColor(hexString: "#FACA50")
        case .errorRed:
            return UIColor(hexString: "#FF3B30")
        }
    }
}

enum CustomButtonType {
    case blueButton
    case whiteButton
    case greenButton
}

enum CustomImagesNames: String {
    case stroke = "Stroke"
    case reversedStroke = "ReversedStroke"
    case bag = "Bag"
    case mark = "Mark"
    case miniCar = "MiniCar"
    case orangeMark = "OrangeMark"
    case disableTaxiButton = "DisableTaxiButton"
    case disableFoodButton = "DisableFoodButton"
    case taxiButton = "TaxiButton"
    case foodButton = "FoodButton"
    case flag = "Flag"
    case gradient = "Gradient"
    case checkMark = "CheckMark"
}
