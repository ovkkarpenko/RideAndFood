//
//  BaseCustomUIComponents.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 23.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    private var customType: CustomButtonType?
    
    override var isEnabled: Bool {
        didSet {
            if self.isEnabled {
                setBackgroundColor()
            } else {
                self.backgroundColor = Colors.getColor(.disableGray)()
            }
        }
    }
    
    func customizeButton(type: CustomButtonType) {
        customType = type
        
        switch type {
        case .blueButton:
            self.layer.cornerRadius = generalCornerRaduis
            setBackgroundColor()
            self.setTitleColor(Colors.getColor(.buttonWhite)(), for: .normal)
            
        case .whiteButton:
            self.layer.cornerRadius = generalCornerRaduis
            setBackgroundColor()
            self.setTitleColor(Colors.getColor(.buttonBlue)(), for: .normal)
        case .greenButton:
            self.layer.cornerRadius = generalCornerRaduis
            setBackgroundColor()
            self.setTitleColor(Colors.getColor(.buttonWhite)(), for: .normal)
        }
    }
    
    private func setBackgroundColor() {
        if let customType = customType {
            switch customType {
            case .blueButton:
                self.backgroundColor = Colors.getColor(.buttonBlue)()
            case .whiteButton:
                self.backgroundColor = Colors.getColor(.buttonWhite)()
            case .greenButton:
                self.backgroundColor = Colors.getColor(.buttonGreen)()
            }
        }
    }
}

class InsetLabel: UILabel {
    override func drawText(in rect: CGRect) {
        super.drawText(in: CGRect(x: 25, y: 0, width: rect.width, height: rect.height))
    }
}
