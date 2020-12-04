//
//  SelectTariffView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 03.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class SelectTariffView: UIView {
    
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
    
    private lazy var strokeImageView: UIImageView = {
        let image = UIImage(named: "Stroke")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var firstTextField: CustomTextView = {
        let textField = CustomTextView(textViewType: .currentAddress)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var secondTextField: CustomTextView = {
        let textField = CustomTextView(textViewType: .destinationAddress)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private let offset: CGFloat = 400
    private let padding: CGFloat = 20
    private let screenHeight = UIScreen.main.bounds.height
    
    private lazy var contentViewTopAnchorConstraint = contentView.topAnchor.constraint(equalTo: topAnchor, constant: screenHeight+offset)
    private lazy var contentViewBottomAnchorConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -screenHeight-offset)
    
    private func setupUI() {
        addSubview(contentView)
        contentView.addSubview(firstTextField)
        contentView.addSubview(secondTextField)
        contentView.addSubview(strokeImageView)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentViewTopAnchorConstraint,
            contentViewBottomAnchorConstraint,
            
            strokeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            strokeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding+20),
            strokeImageView.widthAnchor.constraint(equalToConstant: 12),
            
            firstTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            firstTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            firstTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            
            secondTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            secondTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            secondTextField.topAnchor.constraint(equalTo: firstTextField.bottomAnchor, constant: padding),
        ])
    }
    
    func show() {
        contentViewTopAnchorConstraint.constant = offset
        contentViewBottomAnchorConstraint.constant = 0
        
        UIView.animate(withDuration: generalAnimationDuration, delay: 0, options: [.curveEaseOut]) { [weak self] in
            self?.layoutIfNeeded()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) { [weak self] in
            self?.firstTextField.textField.becomeFirstResponder()
            self?.secondTextField.textField.becomeFirstResponder()
        }
    }
    
    func dismiss() {
        //        UIView.animate(withDuration: generalAnimationDuration, delay: 0, options: [.curveLinear]) { [weak self] in
        //            guard let self = self else { return }
        //            self.backView.layer.frame.origin.y += self.backView.frame.height
        //
        //        } completion: { [weak self] _ in
        //            self?.removeFromSuperview()
        //        }
    }
}
