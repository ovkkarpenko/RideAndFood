//
//  CodeConfirmationView.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 23.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class CodeConfirmationView: UIView {
    
    // MARK: - UI
    
    private lazy var hiddenTextField: UITextField = {
        let textField = UITextField()
        textField.isHidden = true
        textField.delegate = textFieldDelegate
        textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = LoginStrings.headerConfirmationCode.text()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var numberInputs: [NumberInputView] = [
        .init(),
        .init(),
        .init(),
        .init()
    ]
    
    private lazy var resendCodeTextView: UITextView = {
        let textView = UITextView()
        textView.linkTextAttributes = [.foregroundColor: ColorHelper.primary.color() as Any]
        textView.attributedText = resendString
        textView.delegate = resendCodeTextViewDelegate
        textView.textContainerInset = .zero
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private var centerYConstraint: NSLayoutConstraint?
    
    // MARK: - Private properties
    
    private lazy var textFieldDelegate = CodeConfirmationTextFieldDelegate()
    private lazy var resendCodeTextViewDelegate = ResendCodeTextViewDelegate()
    
    private var valueChangedBlock: ((Bool, String?) -> Void)?
    private var phoneNumberString: String?
    
    private var isCompleted = false {
        didSet {
            valueChangedBlock?(isCompleted, hiddenTextField.text)
        }
    }
    
    private var numberOfSeconds = 0 {
        didSet {
            updateSeconds()
        }
    }
    
    private lazy var resendString: NSMutableAttributedString = {
        let string = NSMutableAttributedString(attributedString: resendDescriptionString)
        string.append(resendSecondsString)
        return string
    }()
    
    private var resendDescriptionString: NSMutableAttributedString {
        let descriptionString = "\(LoginStrings.codeDescriptionBegin.text()) \(phoneNumberString ?? "") \(LoginStrings.codeDescriptionEnd.text()) "
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let string = NSMutableAttributedString(string: descriptionString,
                                               attributes: [
                                                .foregroundColor: ColorHelper.secondaryText.color() as Any,
                                                .font: FontHelper.regular12.font() as Any,
                                                .paragraphStyle: paragraph])
        return string
    }
    
    private var resendSecondsString: NSMutableAttributedString {
        let resendLink = "\(LoginStrings.resendCodeAfter.text()) \(numberOfSeconds) \(LoginStrings.resendCodeSeconds.text())"
        let string = NSMutableAttributedString(string: resendLink,
                                               attributes: [
                                                .foregroundColor: ColorHelper.primary.color() as Any,
                                                .font: FontHelper.regular12.font() as Any])
        return string
    }
    
    private var timer: Timer?
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    // MARK: - Deinitializer
    
    deinit {
        timer?.invalidate()
    }
    
    // MARK: - Public methods
    
    @objc func focusTextField() -> Void {
        hiddenTextField.becomeFirstResponder()
    }
    
    func runTimer() -> Void {
        timer?.invalidate()
        numberOfSeconds = 30
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] timer in
            self?.numberOfSeconds -= 1
            if self?.numberOfSeconds == 0 {
                timer.invalidate()
            }
        })
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        addSubview(hiddenTextField)
        
        let inputsStackView = UIStackView(arrangedSubviews: numberInputs)
        inputsStackView.spacing = 15
        inputsStackView.distribution = .fillEqually
        inputsStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(focusTextField)))
        
        let verticalStackView = UIStackView(arrangedSubviews: [titleLabel, inputsStackView, resendCodeTextView])
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.spacing = 15
        verticalStackView.setCustomSpacing(19, after: titleLabel)
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .center
        
        addSubview(verticalStackView)
        centerYConstraint = verticalStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        centerYConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            hiddenTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            hiddenTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            hiddenTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            verticalStackView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            verticalStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            verticalStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    @objc private func textFieldChanged() {
        numberInputs.enumerated().forEach {
            guard let text = hiddenTextField.text else { return }
            $0.element.number = text.count > $0.offset ? text[text.startIndex(offsetBy: $0.offset)] : nil
        }
        isCompleted = hiddenTextField.text?.count == 4
    }
    
    private func updateSeconds() {
        let resendDescriptionStringLength = resendDescriptionString.length
        let resendSecondsRange = NSRange(location: resendDescriptionStringLength, length: resendString.length - resendDescriptionStringLength)
        if numberOfSeconds > 0 {
            resendString.removeAttribute(.link, range: .init(location: 0, length: resendString.length))
            let range = (resendString.string as NSString).range(of: "\(LoginStrings.resendCodeAfter.text()) \(numberOfSeconds + 1)")
            let string = "\(LoginStrings.resendCodeAfter.text()) \(numberOfSeconds)"
            if range.location > resendString.length - 1 {
                resendString.replaceCharacters(in: resendSecondsRange, with: resendSecondsString)
            } else {
                resendString.replaceCharacters(in: range, with: string)
            }
        } else {
            let string = NSAttributedString(string: LoginStrings.resendCodeLink.text(), attributes: [.link: "resendCode://"])
            resendString.replaceCharacters(in: resendSecondsRange, with: string)
        }
        
        resendCodeTextView.attributedText = resendString
    }
}

// MARK: - ConfigurableView

extension CodeConfirmationView: IConfigurableView {
    
    func configure(with model: CodeConfirmationViewModel) {
        valueChangedBlock = model.valueChangedBlock
        resendCodeTextViewDelegate.pressedCallback = { [weak self] in
            model.resendCodePressedBlock?()
            self?.runTimer()
        }
        phoneNumberString = model.phoneNumber
        let range = (resendString.string as NSString).range(of: "\(LoginStrings.codeDescriptionBegin.text()) ")
        resendString.replaceCharacters(in: range, with: "\(LoginStrings.codeDescriptionBegin.text()) \(phoneNumberString ?? "")")
        resendCodeTextView.attributedText = resendString
    }
}
