//
//  TripDurationView.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 15.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class TripDurationView: UIView {
    
    // MARK: - UI
    
    private lazy var tripDurationView: UIView = {
        
        let view = UIView()
        view.frame.size = .init(width: 125, height: 40)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = FontHelper.regular15.font()
        label.textColor = .white
        let time = Int.random(in: 3...100)
        label.text = "≈\(time) \(StringsHelper.minutes.text())"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let colorLeft =  UIColor(red: 0.984, green: 0.557, blue: 0.314, alpha: 1).cgColor
        let colorRight = UIColor(red: 0.239, green: 0.231, blue: 1, alpha: 1).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorLeft, colorRight]
        gradientLayer.locations = [0.24, 0.71]
        gradientLayer.transform = CATransform3DMakeRotation(.pi/2, 0, 0, 1)
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = 15
        return gradientLayer
    }()
    
    private let padding: CGFloat = 10
    private let minWidth: CGFloat = 125
    
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
        
        gradientLayer.frame = bounds
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        layer.insertSublayer(gradientLayer, at:0)
        addSubview(mainLabel)
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(greaterThanOrEqualToConstant: minWidth),
            mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            mainLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            mainLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            mainLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
    }
}
