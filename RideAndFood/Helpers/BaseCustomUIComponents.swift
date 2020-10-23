//
//  BaseCustomUIComponents.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 23.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    func customizeButton(type: CustomButtonType) {
        switch type {
        case .blueButton:
            self.layer.cornerRadius = 15
            self.backgroundColor = Colors.getColor(.buttonBlue)()
            self.setTitleColor(Colors.getColor(.buttonWhite)(), for: .normal)
        case .whiteButton:
            self.layer.cornerRadius = 15
            self.backgroundColor = Colors.getColor(.buttonWhite)()
            self.setTitleColor(Colors.getColor(.buttonBlue)(), for: .normal)
        case .greenButton:
            self.layer.cornerRadius = 15
            self.backgroundColor = Colors.getColor(.buttonGreen)()
            self.setTitleColor(Colors.getColor(.buttonWhite)(), for: .normal)
        }
    }
}
