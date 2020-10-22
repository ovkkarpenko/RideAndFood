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

enum Colors {
    case buttonBlue
    case buttonWhite
    case borderGray
    
    func getColor() -> UIColor {
        switch self {
        case .buttonBlue:
            return UIColor(hexString: "#3D3BFF")
        case .buttonWhite:
            return UIColor(hexString: "#FFFFFF")
        case .borderGray:
            return UIColor(hexString: "#CCCCCC")
        }
    }
}

enum CornerRadiuses {
    case raduis9
    case raduis10
    case raduis14
    case raduis15
    
    func getRadius() -> CGFloat {
        switch self {
        case .raduis9:
            return 9
        case .raduis10:
            return 10
        case .raduis14:
            return 14
        case .raduis15:
            return 15
        }
    }
}

public extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
