//
//  PrimaryButton.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 20.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class PrimaryButton: UIButton {
    
    // MARK: - Public properties
    
    override var isEnabled: Bool {
        didSet {
            UIView.animate(withDuration: ConstantsHelper.baseAnimationDuration.value()) {
                self.backgroundColor = self.isEnabled ? ColorHelper.primary.color() : ColorHelper.disabledButton.color()
            }
        }
    }
    
    lazy var heightConstraint = heightAnchor.constraint(equalToConstant: heightConstant)
    
    // MARK: - Private properties
    
    private let heightConstant: CGFloat = 50
    private let cornerRadius: CGFloat = 15
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    convenience init(title: String) {
        self.init(type: .system)
        
        setTitle(title, for: .normal)
    }
    
    // MARK: - Private methods
    
    private func setup() {
        backgroundColor = ColorHelper.primary.color()
        setTitleColor(ColorHelper.primaryButtonText.color(), for: .normal)
        titleLabel?.font = FontHelper.regular17.font()
        translatesAutoresizingMaskIntoConstraints = false
        heightConstraint.isActive = true
        layer.cornerRadius = cornerRadius
    }
}
