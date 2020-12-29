//
//  ServiceButtonView.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 01.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class ServiceButtonView: UIView {
    
    // MARK: - UI
    
    private lazy var bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontHelper.semibold15.font()
        label.textColor = ColorHelper.primaryButtonText.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(nil, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let verticalPadding: CGFloat = 9
    private let horizontalPadding: CGFloat = 14
    
    // MARK: - Public properties
    
    var bgImage: UIImage? {
        didSet {
            bgImageView.image = bgImage
        }
    }
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var titleColor: UIColor? {
        didSet {
            titleLabel.textColor = titleColor
        }
    }
    
    var action: (() -> Void)?
    
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
    
    // MARK: - Private methods
    
    private func setupLayout() {
        addSubview(bgImageView)
        addSubview(titleLabel)
        addSubview(button)
        
        NSLayoutConstraint.activate([
            bgImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgImageView.topAnchor.constraint(equalTo: topAnchor),
            bgImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bgImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: horizontalPadding),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: verticalPadding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -horizontalPadding),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor,constant: -verticalPadding),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.topAnchor.constraint(equalTo: topAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    @objc private func buttonTapped() {
        action?()
    }
}
