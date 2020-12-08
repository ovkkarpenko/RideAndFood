//
//  PromoCodeButtonView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 08.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class PromoCodeButtonView: UIView {
    
    var buttonPressedCallback: (() -> ())?
    
    private lazy var iconImageView: UIImageView = {
        let image = UIImage(named: "promo")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var saleLabel: UILabel = {
        let salelabel = UILabel()
        salelabel.alpha = 0
        salelabel.textColor = UIColor(red: 0.204, green: 0.78, blue: 0.349, alpha: 1)
        salelabel.translatesAutoresizingMaskIntoConstraints = false
        salelabel.font = .boldSystemFont(ofSize: 15)
        salelabel.text = "-15%"
        return salelabel
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.text = SelectTariffStrings.promoCodeTitle.text()
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(promoCodeButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private lazy var titleLabelLeadingAnchorConstraint = titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 5)
    
    private let padding: CGFloat = 20
    
    private func setupUI() {
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(saleLabel)
        addSubview(button)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 1),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            
            titleLabelLeadingAnchorConstraint,
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: padding),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            saleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            saleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        backgroundColor = .white
        layer.shadowColor = ColorHelper.shadow.color()?.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 3
        layer.cornerRadius = 15
    }
    
    func disable() {
        titleLabelLeadingAnchorConstraint.isActive = false
        titleLabel.leadingAnchor.constraint(equalTo: saleLabel.trailingAnchor, constant: 5).isActive = true
        
        UIView.animate(withDuration: generalAnimationDuration, delay: 0, options: [.curveEaseIn]) { [weak self] in
            self?.backgroundColor = UIColor(red: 0.942, green: 0.942, blue: 0.942, alpha: 1)
            self?.layer.shadowOpacity = 0
            self?.titleLabel.textColor = ColorHelper.secondaryText.color()
            self?.saleLabel.alpha = 1
            self?.iconImageView.alpha = 0
            self?.layoutIfNeeded()
        }
        
        button.isEnabled = false
    }
    
    @objc private func promoCodeButtonPressed() {
        buttonPressedCallback?()
    }
}
