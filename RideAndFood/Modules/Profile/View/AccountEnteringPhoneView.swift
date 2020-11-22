//
//  AccountEnteringPhoneView.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 15.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class AccountPhoneEnteringView: UIView {
    
    // MARK: - UI
    
    private lazy var phoneTextField: PhoneTextField = {
        let textField = PhoneTextField()
        textField.configure(with: .init(valueChangedCallback: { [weak self] isCompleted in
            self?.confirmButton.isEnabled = isCompleted
        }))
        return textField
    }()
    
    private lazy var confirmButton: PrimaryButton = {
        let button = PrimaryButton(title: StringsHelper.confirm.text())
        button.addTarget(self, action: #selector(confirmButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [phoneTextField, confirmButton])
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Private properties
    
    private var confirmButtonPressedBlock: (() -> Void)?
    
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
    
    @objc private func confirmButtonPressed() {
        confirmButtonPressedBlock?()
    }
}

// MARK: - ConfigurableView

extension AccountPhoneEnteringView: IConfigurableView {
    
    func configure(with model: AccountEnteringPhoneViewModel) {
        confirmButtonPressedBlock = model.confirmButtonPressedBlock
    }
}
