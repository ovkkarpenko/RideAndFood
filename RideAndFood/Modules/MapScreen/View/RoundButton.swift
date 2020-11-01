//
//  RoundButton.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 01.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class RoundButton: UIButton {
    
    // MARK: - UI

    private let padding: CGFloat = 12
    private let size: CGFloat = 40
    
    // MARK: - Public Properties
    
    var bgImage: UIImage? {
        didSet {
            setBackgroundImage(bgImage, for: .normal)
            imageEdgeInsets = .init(top: padding, left: padding, bottom: padding, right: padding)
        }
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    // MARK: - Lifecycle methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.width / 2
        layer.shadowColor = ColorHelper.shadow.color()?.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        backgroundColor = ColorHelper.background.color()
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: size).isActive = true
        heightAnchor.constraint(equalToConstant: size).isActive = true
    }
}
