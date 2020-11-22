//
//  PromoCodeTextField.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 02.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import InputMask

class PromoCodeTextField: UITextField {

    // MARK: - Public properties
    
    var valueChangedCallback: ((Bool) -> Void)?
    var hasError = false {
        didSet {
            if hasError {
                UIView.animate(withDuration: ConstantsHelper.baseAnimationDuration.value()) {
                    self.bottomLine.backgroundColor = ColorHelper.error.color()?.cgColor
                }
            }
        }
    }
    
    // MARK: - UI
    
    private lazy var bottomLine = CALayer()
    
    // MARK: - Private properties
    
    private var isCompleted = false {
        didSet {
            valueChangedCallback?(isCompleted)
        }
    }
    
    private lazy var listener =
        MaskedTextFieldDelegate(primaryFormat: "R - [000000]") { [weak self] _, _, isCompleted in
        
        UIView.animate(withDuration: ConstantsHelper.baseAnimationDuration.value()) {
            self?.bottomLine.backgroundColor = isCompleted ? ColorHelper.primary.color()?.cgColor :
                ColorHelper.disabledButton.color()?.cgColor
        }
        
        self?.isCompleted = isCompleted
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    // MARK: - Lifecycle methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bottomLine.frame = CGRect(x: 0,
                                  y: frame.height + 4,
                                  width: frame.width,
                                  height: 1)
    }
    
    // MARK: - Private methods
    
    private func setup() {
        delegate = listener
        keyboardType = .phonePad
        
        bottomLine.backgroundColor = ColorHelper.disabledButton.color()?.cgColor
        borderStyle = UITextField.BorderStyle.none
        layer.addSublayer(bottomLine)
    }
}
