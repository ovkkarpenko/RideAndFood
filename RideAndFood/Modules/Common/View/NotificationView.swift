//
//  NotificationView.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 06.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class NotificationView: UIView {
    
    // MARK: - UI
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = FontHelper.semibold12.font()
        label.textColor = ColorHelper.primaryButtonText.color()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "CloseButtonLight")
        button.tintColor = .white
        button.setImage(UIImage(named: "CloseButtonLight"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let padding: CGFloat = 15
    
    // MARK: - Private properties
    
    private var closeBlock: (() -> Void)?
    private var tappedBlock: (() -> Void)?
    
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
        backgroundColor = ColorHelper.notification.color()
        layer.cornerRadius = 15
        
        addSubview(iconImageView)
        addSubview(messageLabel)
        addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 5),
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped)))
    }
    
    @objc private func closeButtonTapped() {
        closeBlock?()
    }
    
    @objc private func tapped() {
        tappedBlock?()
    }
}

// MARK: - ConfigurableView

extension NotificationView: IConfigurableView {
    
    func configure(with model: NotificationModel) {
        iconImageView.image = model.iconImage
        messageLabel.text = model.messageText
        closeBlock = model.closeBlock
        tappedBlock = model.tappedBlock
    }
}
