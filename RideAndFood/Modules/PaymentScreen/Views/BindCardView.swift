//
//  BindCardView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 06.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import RxSwift
import Foundation

class BindCardView: UIView {
    
    var showErrorAlert: (() -> ())?
    var confirmCallback: ((PaymentCardDetails) -> ())?
    
    private lazy var cardNumberTextField: MaskTextField = {
        let textField = MaskTextField(format: "[0000] [0000] [0000] [0000]", valueChangedCallback: { [weak self] isCompleted in
            if isCompleted { self?.cardDateTextField.becomeFirstResponder() }
        })
        textField.placeholder = PaymentStrings.bindCardNumberTitle.text()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var cardDateTextField: MaskTextField = {
        let textField = MaskTextField(format: "[00]{/}[00]", valueChangedCallback: { [weak self] isCompleted in
            if isCompleted { self?.cardCVVTextField.becomeFirstResponder() }
        })
        textField.placeholder = PaymentStrings.bindCardDateTitle.text()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var cardCVVTextField: MaskTextField = {
        let textField = MaskTextField(format: "[000]", valueChangedCallback: { [weak self] isCompleted in
            if isCompleted { self?.cardCVVTextField.resignFirstResponder() }
        })
        textField.placeholder = PaymentStrings.bindCardCVVTitle.text()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var bindCardButton: PrimaryButton = {
        let button = PrimaryButton(title: PaymentStrings.bindCard.text())
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    private let padding: CGFloat = 25
    
    private let bag = DisposeBag()
    private let viewModel = BindCardViewModel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cardNumberTextField.becomeFirstResponder()
        
        layer.cornerRadius = 15
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setupLayout() {
        backgroundColor = ColorHelper.background.color()
        
        bindCardItems()
        
        addSubview(cardNumberTextField)
        addSubview(cardDateTextField)
        addSubview(cardCVVTextField)
        addSubview(bindCardButton)
        
        NSLayoutConstraint.activate([
            cardNumberTextField.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            cardNumberTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            cardNumberTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
            
            cardDateTextField.topAnchor.constraint(equalTo: cardNumberTextField.bottomAnchor, constant: padding),
            cardDateTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            cardDateTextField.widthAnchor.constraint(equalToConstant: 100),
            
            cardCVVTextField.topAnchor.constraint(equalTo: cardNumberTextField.bottomAnchor, constant: padding),
            cardCVVTextField.leftAnchor.constraint(equalTo: cardDateTextField.rightAnchor, constant: padding),
            cardCVVTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
            
            bindCardButton.topAnchor.constraint(equalTo: cardDateTextField.bottomAnchor, constant: 40),
            bindCardButton.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            bindCardButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
        ])
        layer.shadowColor = ColorHelper.shadow.color()?.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
    }
    
    private func bindCardItems() {
        cardNumberTextField.rx
            .controlEvent(.editingDidEnd)
            .withLatestFrom(cardNumberTextField.rx.text.orEmpty)
            .bind(to: viewModel.cardNumber)
            .disposed(by: bag)
        
        cardDateTextField.rx
            .controlEvent(.editingDidEnd)
            .withLatestFrom(cardDateTextField.rx.text.orEmpty)
            .bind(to: viewModel.cardDate)
            .disposed(by: bag)
        
        cardCVVTextField.rx
            .controlEvent(.editingDidEnd)
            .withLatestFrom(cardCVVTextField.rx.text.orEmpty)
            .bind(to: viewModel.cardCVV)
            .disposed(by: bag)
        
        bindCardButton.rx
            .tap
            .withLatestFrom(viewModel.userInputs())
            .subscribe { card in
                
                self.viewModel.addCard(card) { cardDetails in
                    if let cardDetails = cardDetails {
                        DispatchQueue.main.async {
                            self.confirmCallback?(cardDetails)
                        }
                    } else {
                        self.showErrorAlert?()
                    }
                }
            }.disposed(by: bag)
        
        viewModel.isCompleted()
            .subscribe { isCompleted in
                self.bindCardButton.isEnabled = isCompleted
            }.disposed(by: bag)
    }
}
