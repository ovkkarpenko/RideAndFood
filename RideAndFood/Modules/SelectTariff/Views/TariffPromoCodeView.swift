//
//  TariffPromoCodeView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 07.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class TariffPromoCodeView: UIView, CustromViewProtocol {
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorHelper.background.color()
        view.layer.shadowColor = ColorHelper.shadow.color()?.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 10
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var transparentView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var promoCodeTextField: MaskTextField = {
        let textField = MaskTextField(format: "[A]-[000000]", valueChangedCallback: nil)
        textField.placeholder = "R-123456"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var confirmButton: PrimaryButton = {
        let button = PrimaryButton()
        button.setTitle(PaymentStrings.confirmButtonTitle.text(), for: .normal)
        button.addTarget(self, action: #selector(confirmButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var promoCodeActivetedView: PromoCodeActivetedView = {
        let view = PromoCodeActivetedView()
        view.dismissCallback = { [weak self] in
            self?.dismiss { [weak self] in
                self?.removeFromSuperview()
            }
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        if touches.first?.view == transparentView {
            dismiss { [weak self] in
                self?.removeFromSuperview()
            }
        }
    }
    
    private let offset: CGFloat = UIScreen.main.bounds.height-150
    private let padding: CGFloat = 20
    private let screenHeight = UIScreen.main.bounds.height
    
    private lazy var contentViewTopAnchorConstraint = contentView.topAnchor.constraint(equalTo: topAnchor, constant: screenHeight+offset)
    private lazy var contentViewBottomAnchorConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -screenHeight-offset)
 
    private func setupUI() {
        addSubview(transparentView)
        addSubview(contentView)
        contentView.addSubview(promoCodeTextField)
        contentView.addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            transparentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            transparentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            transparentView.topAnchor.constraint(equalTo: topAnchor),
            transparentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentViewTopAnchorConstraint,
            contentViewBottomAnchorConstraint,
            
            promoCodeTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            promoCodeTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            promoCodeTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            
            confirmButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            confirmButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            confirmButton.topAnchor.constraint(equalTo: promoCodeTextField.bottomAnchor, constant: padding)
        ])
    }
    
    func show() {
        contentViewTopAnchorConstraint.constant = offset
        contentViewBottomAnchorConstraint.constant = 0
        
        UIView.animate(withDuration: generalAnimationDuration, delay: 0, options: [.curveEaseOut]) { [weak self] in
            self?.transparentView.alpha = 0.3
            self?.layoutIfNeeded()
        }
    }
    
    func dismiss(_ completion: (() -> ())? = nil) {
        contentViewTopAnchorConstraint.constant = screenHeight+offset
        contentViewBottomAnchorConstraint.constant = -screenHeight-offset
        
        UIView.animate(withDuration: generalAnimationDuration, delay: 0, options: [.curveEaseIn]) { [weak self] in
            if completion != nil { self?.transparentView.alpha = 0 }
            self?.layoutIfNeeded()
        } completion: { _ in
            completion?()
        }
    }
    
    @objc private func confirmButtonPressed() {
        dismiss()
        
        addSubview(promoCodeActivetedView)
        NSLayoutConstraint.activate([
            promoCodeActivetedView.leadingAnchor.constraint(equalTo: leadingAnchor),
            promoCodeActivetedView.trailingAnchor.constraint(equalTo: trailingAnchor),
            promoCodeActivetedView.topAnchor.constraint(equalTo: topAnchor),
            promoCodeActivetedView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        layoutIfNeeded()
        promoCodeActivetedView.show()
    }
}
