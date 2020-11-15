//
//  SecondaryButton.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 13.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class SecondaryButton: UIButton {
    
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
        backgroundColor = ColorHelper.background.color()
        setTitleColor(ColorHelper.primaryText.color(), for: .normal)
        titleLabel?.font = FontHelper.regular17.font()
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
        layer.cornerRadius = cornerRadius
    }
}
