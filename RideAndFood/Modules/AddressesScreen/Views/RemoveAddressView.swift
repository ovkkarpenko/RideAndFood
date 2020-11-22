//
//  RemoveAddressView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 13.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import Foundation
import RxSwift

class RemoveAddressView: UIView {
    
    var delegate: RemoveAddressDelegate?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .red
        label.text = AddAddressesStrings.removeTitle.text()
        label.font = .systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var removeButton: PrimaryButton = {
        let button = PrimaryButton(title: AddAddressesStrings.removeButton.text())
        button.addTarget(self, action: #selector(removeButtomPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var cencelButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        button.setTitle(AddAddressesStrings.cencelButton.text(), for: .normal)
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
    
    private let padding: CGFloat = 20
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 15
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setupLayout() {
        backgroundColor = ColorHelper.background.color()
        
        addSubview(titleLabel)
        addSubview(removeButton)
        addSubview(cencelButton)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            
            removeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            removeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            removeButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            
            cencelButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            cencelButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            cencelButton.topAnchor.constraint(equalTo: removeButton.bottomAnchor, constant: padding)
        ])
        
        layer.shadowColor = ColorHelper.shadow.color()?.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
    }
    
    @objc private func removeButtomPressed() {
        delegate?.remove()
    }
    
    @objc private func cencelButtomPressed() {
        delegate?.cencel()
    }
}
