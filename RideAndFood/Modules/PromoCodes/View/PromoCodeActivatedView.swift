//
//  PromoCodeActivatedView.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 13.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class PromoCodeActivatedView: UIView {
    
    // MARK: - UI
    
    private lazy var successImageView = UIImageView(image: UIImage(named: "Success"))
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontHelper.semibold17.font()
        label.textColor = ColorHelper.success.color()
        label.text = PromoCodesStrings.promoCodeActivated.text()
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorHelper.secondaryText.color()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Public properties
    
    var descriptionText: String? {
        didSet {
            descriptionLabel.text = descriptionText
        }
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [successImageView, titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 11
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
