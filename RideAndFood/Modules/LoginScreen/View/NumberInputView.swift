//
//  NumberInputView.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 23.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class NumberInputView: UIView {
    
    var number: Character? {
        didSet {
            guard let number = number else {
                if let circleLayer = circleLayer {
                    layer.addSublayer(circleLayer)
                }
                numberLabel.isHidden = true
                return
            }
            circleLayer?.removeFromSuperlayer()
            numberLabel.text = "\(number)"
            numberLabel.isHidden = false
        }
    }
    
    // MARK: - UI
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorHelper.primary.color()
        label.textAlignment = .center
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var circleLayer: CAShapeLayer?
    
    private let cornerRadius: CGFloat = 4
    private let circleRadius: CGFloat = 5
    private let size: CGFloat = 35
    private let padding: CGFloat = 12
    
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
        
        drawCircle()
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        backgroundColor = ColorHelper.controlBackground.color()
        layer.cornerRadius = cornerRadius
        addSubview(numberLabel)
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: size),
            heightAnchor.constraint(equalToConstant: size),
            numberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            numberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            numberLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func drawCircle() {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2),
                                      radius: circleRadius,
                                      startAngle: 0,
                                      endAngle: CGFloat(Double.pi * 2),
                                      clockwise: true)
            
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = ColorHelper.primary.color()?.cgColor
        
        circleLayer?.removeFromSuperlayer()
        circleLayer = shapeLayer
        
        if number == nil {
            layer.addSublayer(shapeLayer)
        }
    }
}
