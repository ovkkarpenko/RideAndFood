//
//  UIButton+TwoTitles.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 04.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

extension UIButton {
    func setTitles(left: String, right: String, padding: CGFloat = 15) {
        self.titleLabel?.numberOfLines = 0
        self.titleEdgeInsets = .init(top: padding, left: padding, bottom: padding, right: padding)
        let text = "\(left)\n\(right)"
        
        let attributedString = NSMutableAttributedString(string: text)
        let p1 = NSMutableParagraphStyle()
        let p2 = NSMutableParagraphStyle()
        p1.alignment = .left
        p2.alignment = .right
        p2.paragraphSpacingBefore = -(self.titleLabel?.font.lineHeight ?? 0)
        attributedString.addAttribute(.paragraphStyle,
                                      value: p1,
                                      range: .init(location: 0,
                                                   length: left.count))
        attributedString.addAttributes([.paragraphStyle: p2,
                                        .font: FontHelper.semibold17.font() as Any],
                                       range: .init(location: left.count,
                                                    length: right.count + 1))
        attributedString.addAttribute(.foregroundColor, value: ColorHelper.primaryButtonText.color() as Any,
                                      range: .init(location: 0,
                                                   length: attributedString.length))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}


