//
//  AlertTextField.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 26.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

@IBDesignable
class AlertTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        setup()
    }
    
    func setup() {
        font = .systemFont(ofSize: 17)
        borderStyle = .none
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: frame.height - 1, width: frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor(red: 0.817, green: 0.817, blue: 0.817, alpha: 1).cgColor
        layer.addSublayer(bottomLine)
    }
}
