//
//  TaxiCircleButtonView.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 16.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class TaxiCircleButtonView: UIView {
    
    // MARK: - UI
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.layer.shadowColor = ColorHelper.shadow.color()?.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 3
        button.backgroundColor = ColorHelper.background.color()
        button.contentEdgeInsets = .init(top: 19, left: 19, bottom: 19, right: 19)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontHelper.regular12.font()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Private properties
    
    private let width: CGFloat = 58
    private var buttonTappedBlock: (() -> Void)?
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    // MARK: - Lifecycle methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        button.layer.cornerRadius = button.bounds.width / 2
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        addSubview(button)
        addSubview(titleLabel)
        
        let heightConstraint = button.heightAnchor.constraint(equalToConstant: width)
        let widthConstraint = button.heightAnchor.constraint(equalToConstant: width)
        heightConstraint.priority = .required
        widthConstraint.priority = .required
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.topAnchor.constraint(equalTo: topAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 7),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func buttonTapped() {
        buttonTappedBlock?()
    }
}

// MARK: - ConfigurableView

extension TaxiCircleButtonView: IConfigurableView {
    
    func configure(with model: TaxiCircleButtonViewModel) {
        button.setImage(model.image, for: .normal)
        titleLabel.text = model.title
        buttonTappedBlock = model.buttonTappedBlock
    }
}
