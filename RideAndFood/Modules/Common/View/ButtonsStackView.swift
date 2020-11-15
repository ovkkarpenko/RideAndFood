//
//  ButtonsStackView.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 13.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class ButtonsStackView: UIView {
    
    // MARK: - UI
    
    private lazy var primaryButton: PrimaryButton = {
        let button = PrimaryButton()
        button.addTarget(self, action: #selector(primaryButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var secondaryButton: SecondaryButton = {
        let button = SecondaryButton(title: AccountStrings.changePhoneNumber.text())
        button.addTarget(self, action: #selector(secondaryButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [primaryButton, secondaryButton])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Private properties
    
    private var primaryButtonPressedBlock: (() -> Void)?
    private var secondaryButtonPressedBlock: (() -> Void)?
    
    
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
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func primaryButtonPressed() {
        primaryButtonPressedBlock?()
    }
    
    @objc private func secondaryButtonPressed() {
        secondaryButtonPressedBlock?()
    }
}

// MARK: - IConfigurableView

extension ButtonsStackView: IConfigurableView {
    func configure(with model: ButtonsStackViewModel) {
        primaryButton.setTitle(model.primaryTitle, for: .normal)
        secondaryButton.setTitle(model.secondaryTitle, for: .normal)
        primaryButtonPressedBlock = model.primaryButtonPressedBlock
        secondaryButtonPressedBlock = model.secondaryButtonPressedBlock
    }
}
