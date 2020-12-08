//
//  PointsButtonView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 08.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class PointsButtonView: UIView {
    
    var buttonPressedCallback: (() -> ())?
    
    private lazy var iconImageView: UIImageView = {
        let image = UIImage(named: "points")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.text = SelectTariffStrings.pointsTitle.text()
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(pointsButtonPressed), for: .touchUpInside)
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
    
    private let padding: CGFloat = 20
    
    private func setupUI() {
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(button)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 1),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: padding),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
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
        UIView.animate(withDuration: generalAnimationDuration, delay: 0, options: [.curveEaseIn]) { [weak self] in
            self?.backgroundColor = UIColor(red: 0.942, green: 0.942, blue: 0.942, alpha: 1)
            self?.layer.shadowOpacity = 0
            
            self?.layoutIfNeeded()
        }
        
        button.isEnabled = false
    }
    
    @objc private func pointsButtonPressed() {
        buttonPressedCallback?()
    }
}
