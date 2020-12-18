//
//  TripDurationView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 18.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class TripDurationView: UIView {
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        label.text = "≈15 мин"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 125, height: 40))
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func setupUI() {
        addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            valueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            valueLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
        ])
        
        let colorLeft =  UIColor(red: 0.984, green: 0.557, blue: 0.314, alpha: 1).cgColor
        let colorRight = UIColor(red: 0.239, green: 0.231, blue: 1, alpha: 1).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorLeft, colorRight]
        gradientLayer.locations = [0.24, 0.71]
        gradientLayer.transform = CATransform3DMakeRotation(.pi/2, 0, 0, 1)
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = 15
        
        layer.insertSublayer(gradientLayer, at:0)
    }
}
