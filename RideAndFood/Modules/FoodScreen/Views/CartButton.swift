//
//  CartButton.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 06.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class CartButton: UIButton {
    
    // MARK: - UI
    
    private lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var mainLabel = UILabel()
    
    private let padding: CGFloat = 15
    
    // MARK: - Initializers
    
    convenience init(icon: UIImage?,
                     title: String?,
                     target: Any?,
                     action: Selector,
                     for event: UIControl.Event = .touchUpInside) {
        self.init(type: .system)
        
        mainLabel.text = title
        iconView.image = icon
        addTarget(target, action: action, for: event)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        backgroundColor = ColorHelper.background.color()
        let stackView = UIStackView(arrangedSubviews: [
            iconView,
            mainLabel
        ])
        stackView.distribution = .fillProportionally
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
        
        layer.cornerRadius = 15
        layer.shadowColor = ColorHelper.shadow.color()?.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 5
    }
}
