//
//  LoginView.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 20.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    // MARK: - Public properties
    
    var valueChangedCallback: ((Bool) -> Void)?
    var termsOfUsePressedCallback: (() -> Void)? {
        didSet {
            termsOfUseDelegate.pressedCallback = termsOfUsePressedCallback
        }
    }
    
    var isCompleted = false {
        didSet {
            if let valueChangedCallback = valueChangedCallback {
               valueChangedCallback(isCompleted)
            }
        }
    }
    
    var phoneNumberString: String? {
        phoneTextField.text
    }
    
    // MARK: - UI
    
    private lazy var bgImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "LoginScreenMan"))
        iv.contentMode = .scaleAspectFill
        iv.setContentHuggingPriority(.required, for: .vertical)
        iv.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorHelper.primaryText.color()
        label.text = LoginStrings.headerPhoneNumber.text()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var phoneTextField: PhoneTextField = {
        let maskedTextField = PhoneTextField(frame: .zero)
        maskedTextField.valueChangedCallback = { [weak self] isCompleted in
            self?.isCompleted = isCompleted && self?.checkbox.isChecked ?? false
        }
        maskedTextField.translatesAutoresizingMaskIntoConstraints = false
        return maskedTextField
    }()
    
    private lazy var termsOfUseTextView: UITextView = {
        
        let textView = UITextView()
        let attributedString = NSMutableAttributedString(string: LoginStrings.termsOfUse.text(),
                                                         attributes: [
                                                            .foregroundColor: ColorHelper.secondaryText.color() as Any,
                                                            .font: FontHelper.font12.font() as Any])
        let linkRange = (attributedString.string as NSString).range(of: LoginStrings.termsOfUseLink.text())
        attributedString.addAttribute(.link,
                                      value: "termsOfUse://",
                                      range: linkRange)
        textView.linkTextAttributes = [.foregroundColor: ColorHelper.primary.color() as Any]
        textView.attributedText = attributedString
        textView.delegate = termsOfUseDelegate
        textView.textContainerInset = .zero
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var checkbox: Checkbox = {
        let checkbox = Checkbox()
        checkbox.valueChangedCallback = { [weak self] isCompleted in
            self?.isCompleted = isCompleted && self?.phoneTextField.isCompleted ?? false
        }
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        return checkbox
    }()
    
    private let padding: CGFloat = 25
    
    private lazy var termsOfUseDelegate = TermsOfUseTextViewDelegate()
    
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
        phoneTextField.becomeFirstResponder()
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        let horizontalStackView = UIStackView(arrangedSubviews: [
            checkbox,
            termsOfUseTextView
        ])
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.spacing = 7
        horizontalStackView.alignment = .firstBaseline
        
        addSubview(headerLabel)
        addSubview(bgImageView)
        addSubview(phoneTextField)
        addSubview(horizontalStackView)
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            bgImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -padding),
            bgImageView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
            bgImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: padding),
            phoneTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            phoneTextField.topAnchor.constraint(equalTo: bgImageView.bottomAnchor, constant: padding),
            phoneTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            horizontalStackView.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: padding / 2),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
