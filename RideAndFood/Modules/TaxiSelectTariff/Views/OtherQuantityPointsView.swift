//
//  OtherQuantityPointsView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 09.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class OtherQuantityPointsView: UIView, CustromViewProtocol {
    
    var maxPoints: Int?
    var dismissCallback: ((Int?) -> ())?
    
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
    
    private lazy var pointsTextField: MaskTextField = {
        let textField = MaskTextField(format: "[0…]", valueChangedCallback: { [weak self] isCompleted in
            if isCompleted { self?.confirmButton.isEnabled = true }
        })
        textField.placeholder = SelectTariffStrings.pointsCountTitle.text()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var confirmButton: PrimaryButton = {
        let button = PrimaryButton()
        button.isEnabled = false
        button.setTitle(PaymentStrings.confirmButtonTitle.text(), for: .normal)
        button.addTarget(self, action: #selector(confirmButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let padding: CGFloat = 20
    private let offset: CGFloat = UIScreen.main.bounds.height-160
    private let screenHeight = UIScreen.main.bounds.height
    
    private lazy var contentViewTopAnchorConstraint = contentView.topAnchor.constraint(equalTo: topAnchor, constant: screenHeight+offset)
    private lazy var contentViewBottomAnchorConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -screenHeight-offset)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    deinit {
        removeKeyboardObservation()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        if touches.first?.view == self {
            dismiss { [weak self] in
                self?.dismissCallback?(0)
                self?.removeFromSuperview()
            }
        }
    }
    
    private func setupUI() {
        addSubview(contentView)
        contentView.addSubview(pointsTextField)
        contentView.addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentViewTopAnchorConstraint,
            contentViewBottomAnchorConstraint,
            
            pointsTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            pointsTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            pointsTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            
            confirmButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            confirmButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            confirmButton.topAnchor.constraint(equalTo: pointsTextField.bottomAnchor, constant: padding)
        ])
        
        setKeyboardObserver()
    }
    
    func show() {
        contentViewTopAnchorConstraint.constant = offset
        contentViewBottomAnchorConstraint.constant = 0
        
        UIView.animate(withDuration: generalAnimationDuration, delay: 0, options: [.curveEaseOut]) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
    
    func dismiss(_ completion: (() -> ())? = nil) {
        contentViewTopAnchorConstraint.constant = screenHeight+offset
        contentViewBottomAnchorConstraint.constant = -screenHeight-offset
        
        UIView.animate(withDuration: generalAnimationDuration, delay: 0, options: [.curveEaseIn]) { [weak self] in
            self?.layoutIfNeeded()
        } completion: { _ in
            completion?()
        }
    }
    
    private func setKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardObservation() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
    
        contentViewTopAnchorConstraint.constant = offset-keyboardSize.height
        contentViewBottomAnchorConstraint.constant = keyboardSize.height
        
        UIView.animate(withDuration: generalAnimationDuration) { [weak self] in
            self?.layoutIfNeeded()
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        contentViewBottomAnchorConstraint.constant = 0
        
        UIView.animate(withDuration: generalAnimationDuration) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
    
    @objc private func confirmButtonPressed() {
        if let points = Int(pointsTextField.text ?? "0"),
           let maxPoints = maxPoints,
           points <= maxPoints {
            
            dismiss { [weak self] in
                self?.dismissCallback?(points)
                self?.removeFromSuperview()
            }
        }
    }
}
