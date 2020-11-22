//
//  MaskTextField.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 06.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import InputMask
import RxSwift

class MaskTextField: UITextField {

    // MARK: - Public properties
    
    var valueChangedCallback: ((Bool) -> Void)?
    var isCompleted = false {
        didSet {
            if let valueChangedCallback = valueChangedCallback {
                valueChangedCallback(isCompleted)
            }
        }
    }
    
    // MARK: - UI
    private lazy var bottomLine = CALayer()
    
    // MARK: - Private properties
    
    private let bag = DisposeBag()
    private var listener: MaskedTextFieldDelegate?
    
    // MARK: - Initializers
    
    init(format: String, valueChangedCallback: ((Bool) -> Void)? = nil) {
        super.init(frame: CGRect.zero)
        
        self.listener = MaskedTextFieldDelegate(primaryFormat: format) { [weak self] _, _, isCompleted in
            
            UIView.animate(withDuration: ConstantsHelper.baseAnimationDuration.value()) {
                self?.bottomLine.backgroundColor = isCompleted ? ColorHelper.primary.color()?.cgColor :
                    ColorHelper.disabledButton.color()?.cgColor
            }
            
            self?.isCompleted = isCompleted
        }
        
        self.valueChangedCallback = valueChangedCallback
        
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    func setActive() {
        bottomLine.backgroundColor = ColorHelper.primary.color()?.cgColor
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
