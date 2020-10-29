//
//  AlertButton.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 26.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

@IBDesignable
class AlertButton: UIButton {
    
    @IBInspectable
    var buttonState: Bool = false {
        didSet {
            layer.backgroundColor = buttonState
                ? UIColor(red: 0.239, green: 0.231, blue: 1, alpha: 1).cgColor
                : UIColor(red: 0.817, green: 0.817, blue: 0.817, alpha: 1).cgColor
        }
    }
    
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
        tintColor = .white
        titleLabel?.font = .systemFont(ofSize: 17)
        layer.cornerRadius = 10
    }
}
