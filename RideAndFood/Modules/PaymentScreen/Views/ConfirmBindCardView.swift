//
//  ConfirmBindCardView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 06.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import Foundation
import RxSwift

class ConfirmBindCardView: UIView {
    
    var confirmCallback: (() -> ())?
    var cencelCallback: (() -> ())?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = PaymentStrings.bindCardButtonTitle.text()
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var alertLabel: UILabel = {
        let label = UILabel()
        label.text = PaymentStrings.bindCardAlert("**** 1212").text()
        label.textColor = ColorHelper.secondaryText.color()
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var confirmButton: PrimaryButton = {
        let button = PrimaryButton(title: PaymentStrings.confirmButtonTitle.text())
        button.addTarget(self, action: #selector(confirmButtomPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var cencelButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        button.setTitle(PaymentStrings.celncelButtonTitle.text(), for: .normal)
        button.setTitleColor(ColorHelper.primaryText.color(), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.addTarget(self, action: #selector(cencelButtomPressed), for: .touchUpInside)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 15
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setupLayout() {
        backgroundColor = ColorHelper.background.color()
        
        addSubview(titleLabel)
        addSubview(alertLabel)
        addSubview(confirmButton)
        addSubview(cencelButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
            
            alertLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            alertLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            alertLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
            
            confirmButton.topAnchor.constraint(equalTo: alertLabel.bottomAnchor, constant: padding),
            confirmButton.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            confirmButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
            
            cencelButton.topAnchor.constraint(equalTo: confirmButton.bottomAnchor, constant: 10),
            cencelButton.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            cencelButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
        ])
        layer.shadowColor = ColorHelper.shadow.color()?.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
    }
    
    @objc private func confirmButtomPressed() {
        confirmCallback?()
    }
    
    @objc private func cencelButtomPressed() {
        cencelCallback?()
    }
}
