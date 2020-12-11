//
//  CounterView.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 30.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class CounterView: UIView {
    
    // MARK: - UI
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(ColorHelper.primaryText.color(), for: .normal)
        button.setTitle("+", for: .normal)
        button.backgroundColor = ColorHelper.controlSecondaryBackground.color()
        button.titleLabel?.font = FontHelper.semibold17.font()
        button.addTarget(self, action: #selector(increase), for: .touchUpInside)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return button
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(ColorHelper.primaryText.color(), for: .normal)
        button.setTitle("-", for: .normal)
        button.backgroundColor = ColorHelper.controlSecondaryBackground.color()
        button.titleLabel?.font = FontHelper.semibold17.font()
        button.addTarget(self, action: #selector(decrease), for: .touchUpInside)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return button
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "1"
        return label
    }()
    
    // MARK: - Public properties
    
    lazy var count = 1 {
        didSet {
            countLabel.text = "\(count)"
            if count == 1 {
                minusButton.isEnabled = false
            } else {
                minusButton.isEnabled = true
            }
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
    
    // MARK: - Lifecycle methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 15
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        backgroundColor = ColorHelper.controlBackground.color()
        let stackView = UIStackView(arrangedSubviews: [
            minusButton,
            countLabel,
            plusButton
        ])
        stackView.spacing = 9
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 50),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        layer.masksToBounds = true
        layer.cornerRadius = 15
    }
    
    @objc private func increase() {
        count += 1
    }
    
    @objc private func decrease() {
        count -= 1
    }
}
