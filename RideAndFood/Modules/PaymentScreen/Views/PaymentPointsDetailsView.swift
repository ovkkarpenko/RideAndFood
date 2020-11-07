//
//  PaymentPointsDetailsView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 07.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import Foundation

class PaymentPointsDetailsView: UIView {
    
    var closeCallback: (() -> ())?
    
    private lazy var closeButton: UIButton = {
        let button = RoundButton(type: .system)
        button.tintColor = .black
        button.alpha = 0.3
        button.bgImage = UIImage(systemName: "xmark.circle.fill")
        button.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = PaymentStrings.paymentPointsDetailsTitle.text()
        label.font = .boldSystemFont(ofSize: 26)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = PaymentStrings.paymentPointsDetailsDescription.text()
        label.textColor = ColorHelper.secondaryText.color()
        label.font = .systemFont(ofSize: 15 )
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var iconsStackView: UIStackView = {
        func icon(_ named: String) -> UIImageView {
            let image = UIImage(named: named, in: Bundle.init(path: "Images/PaymentScreen"), with: .none)
            let imageView = UIImageView(image: image)
            imageView.contentMode = .redraw
            return imageView
        }
        
        let stackView = UIStackView(arrangedSubviews: [icon("pointsIcon1"), icon("pointsIcon2"), icon("pointsIcon3"), icon("pointsIcon4")])
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 60
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var newOrderButton: PrimaryButton = {
        let button = PrimaryButton(title: PaymentStrings.paymentPointsDetailsStartCollect.text())
        button.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
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
    private let marginTop: CGFloat = 8
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 15
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setupLayout() {
        backgroundColor = ColorHelper.background.color()
        
        addSubview(closeButton)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(iconsStackView)
        addSubview(newOrderButton)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: marginTop),
            closeButton.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            
            titleLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: marginTop),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: marginTop),
            descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
            
            iconsStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            iconsStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            iconsStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
            iconsStackView.heightAnchor.constraint(equalToConstant: 30),
            
            newOrderButton.topAnchor.constraint(equalTo: iconsStackView.bottomAnchor, constant: 20),
            newOrderButton.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            newOrderButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding)
        ])
    }
    
    @objc private func closeButtonPressed() {
        closeCallback?()
    }
}
