//
//  PromoCodeCardView.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 02.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class PromoCodeCardView: UIView {
    
    // MARK: - UI
    
    private lazy var promoCodeTextField: PromoCodeTextField = {
        let textField = PromoCodeTextField()
        textField.valueChangedCallback = { [weak self] isCompleted in
            self?.isCompleted = isCompleted
            self?.errorText = nil
        }
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.font = FontHelper.regular10.font()
        label.textColor = ColorHelper.error.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var confirmButton: PrimaryButton = {
        let button = PrimaryButton(title: StringsHelper.confirm.text())
        button.isEnabled = false
        button.addTarget(self, action: #selector(confirmButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var confirmButtonBottomConstraint =
        confirmButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                              constant: -padding)
    
    private let padding: CGFloat = 25
    private let errorLabelPadding: CGFloat = 7
    
    private var isCompleted = false {
        didSet {
            confirmButton.isEnabled = isCompleted
        }
    }
    
    // MARK: - Public properties
    
    var bottomPadding: CGFloat {
        get { confirmButtonBottomConstraint.constant }
        set { confirmButtonBottomConstraint.constant = -(padding + newValue) }
    }
    
    var errorText: String? {
        didSet {
            errorLabel.text = errorText
            promoCodeTextField.hasError = errorText != nil
            if errorText != nil {
                confirmButton.isEnabled = true
            }
        }
    }
    
    var confirmBlock: ((String) -> Void)?
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    // MARK: - Public methods
    
    func focusTextView() -> Void {
        promoCodeTextField.becomeFirstResponder()
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        layer.cornerRadius = 15
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.shadowColor = ColorHelper.shadow.color()?.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
        backgroundColor = ColorHelper.background.color()
        addSubview(promoCodeTextField)
        addSubview(errorLabel)
        addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            promoCodeTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            promoCodeTextField.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            promoCodeTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            errorLabel.leadingAnchor.constraint(equalTo: promoCodeTextField.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: promoCodeTextField.trailingAnchor),
            errorLabel.topAnchor.constraint(equalTo: promoCodeTextField.bottomAnchor, constant: errorLabelPadding),
            confirmButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            confirmButton.topAnchor.constraint(equalTo: promoCodeTextField.bottomAnchor,
                                               constant: padding + errorLabelPadding),
            confirmButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            confirmButtonBottomConstraint
        ])
    }
    
    @objc private func confirmButtonPressed() {
        confirmButton.isEnabled = false
        confirmBlock?(promoCodeTextField.allText.replacingOccurrences(of: " ", with: ""))
    }
}
