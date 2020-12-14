//
//  CartButton.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 06.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class CartButton: UIButton {
    
    // MARK: - UI
    
    lazy var iconView: UIView = UIView() {
        didSet {
            stackView.insertArrangedSubview(iconView, at: 0)
        }
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [mainLabel])
        stackView.distribution = .fillProportionally
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var mainLabel = UILabel()
    
    private let padding: CGFloat = 15
    
    // MARK: - Initializers
    
    convenience init(icon: UIView,
                     title: String?,
                     target: Any?,
                     action: Selector,
                     for event: UIControl.Event = .touchUpInside) {
        self.init(type: .system)
        
        mainLabel.text = title
        iconView = icon
        addTarget(target, action: action, for: event)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    // MARK: - Public methods
    
    func setLeftLabel(text: String?) {
        let label = UILabel()
        label.font = FontHelper.semibold15.font()
        label.textColor = ColorHelper.success.color()
        label.text = text
        stackView.removeArrangedSubview(iconView)
        iconView.removeFromSuperview()
        iconView = label
    }
    
    func setRightLabel(text: String?) {
        mainLabel.text = text
    }
    
    func disable() {
        UIView.animate(withDuration: 0.2) {
            self.layer.shadowOpacity = 0
            self.isEnabled = false
            self.mainLabel.textColor = ColorHelper.secondaryText.color()
            self.backgroundColor = ColorHelper.controlBackground.color()
        }
    }
    
    func enable() {
        UIView.animate(withDuration: 0.2) {
            self.layer.shadowOpacity = 0.1
            self.isEnabled = true
            self.mainLabel.textColor = ColorHelper.primaryText.color()
            self.backgroundColor = ColorHelper.background.color()
        }
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        mainLabel.font = FontHelper.regular15.font()
        backgroundColor = ColorHelper.background.color()
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
        
        layer.cornerRadius = 15
        layer.shadowColor = ColorHelper.shadow.color()?.cgColor
        layer.shadowRadius = 5
        enable()
    }
}
