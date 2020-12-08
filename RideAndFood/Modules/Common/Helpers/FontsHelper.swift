//
//  FontsHelper.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 23.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

enum FontHelper {
    case regular8
    case regular10
    case regular12
    case regular15
    case regular17
    case regular26
    case semibold12
    case semibold15
    case semibold17
    
    func font() -> UIFont? {
        switch self {
        case .regular8:
            return .systemFont(ofSize: 8)
        case .regular10:
            return .systemFont(ofSize: 10)
        case .regular12:
            return .systemFont(ofSize: 12)
        case .regular15:
            return .systemFont(ofSize: 15)
        case .regular17:
            return .systemFont(ofSize: 17)
        case .semibold12:
            return .systemFont(ofSize: 12, weight: .semibold)
        case .semibold15:
            return .systemFont(ofSize: 15, weight: .semibold)
        case .semibold17:
            return .systemFont(ofSize: 17, weight: .semibold)
        case .regular26:
            return .systemFont(ofSize: 26)
        }
    }
}

extension String {
    func strikethrough(_ text: String) -> NSAttributedString{
        let range = (self as NSString).range(of: text)
        let attributedString = NSMutableAttributedString(string:self)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughColor, value: UIColor.gray, range: range)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: range)
        
        return attributedString
    }
    
    func changeTextPathColor(_ text: String, color: UIColor) -> NSAttributedString{
        let range = (self as NSString).range(of: text)
        let attributedString = NSMutableAttributedString(string:self)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        
        return attributedString
    }
}
