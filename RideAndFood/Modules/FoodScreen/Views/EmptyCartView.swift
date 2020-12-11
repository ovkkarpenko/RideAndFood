//
//  EmptyCartView.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 11.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class EmptyCartView: UIView {
    
    // MARK: - UI
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "EmptyCart"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorHelper.secondaryText.color()
        label.text = FoodStrings.cartIsEmpty.text()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var confirmButton: PrimaryButton = {
        let button = PrimaryButton(title: FoodStrings.backToShopping.text())
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let padding: CGFloat = 25
    
    // MARK: - Private properties
    
    private var backButtonTappedBlock: (() -> Void)?
    
    // MARK: - Initializers
    
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
        addSubview(imageView)
        addSubview(descriptionLabel)
        addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding / 2),
            confirmButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: padding * 2),
            confirmButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
            confirmButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            confirmButton.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    @objc private func backButtonTapped() {
        backButtonTappedBlock?()
    }
}

// MARK: - ConfigurableView

extension EmptyCartView: IConfigurableView {
    
    func configure(with model: EmptyCartViewModel) {
        backButtonTappedBlock = model.backButtonTappedBlock
    }
}
