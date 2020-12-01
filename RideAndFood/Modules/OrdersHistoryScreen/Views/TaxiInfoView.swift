//
//  TaxiInfoView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 30.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class TaxiInfoView: UIView {
    
    private lazy var driverLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = ColorHelper.secondaryText.color()
        label.text = OrdersHistoryStrings.driverLabel.text()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var driverTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var carLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = ColorHelper.secondaryText.color()
        label.text = OrdersHistoryStrings.carLabel.text()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var carTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var carNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = ColorHelper.secondaryText.color()
        label.text = OrdersHistoryStrings.carNumberLabel.text()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var carNumberTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var travelTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = ColorHelper.secondaryText.color()
        label.text = OrdersHistoryStrings.travelTimeLabel.text()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var travelTimeTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    func setupUI() {
        addSubview(driverLabel)
        addSubview(driverTextLabel)
        addSubview(carLabel)
        addSubview(carTextLabel)
        addSubview(carNumberLabel)
        addSubview(carNumberTextLabel)
        addSubview(travelTimeLabel)
        addSubview(travelTimeTextLabel)
        
        NSLayoutConstraint.activate([
            driverLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            driverLabel.topAnchor.constraint(equalTo: topAnchor),
            driverTextLabel.leadingAnchor.constraint(equalTo: driverLabel.trailingAnchor, constant: 3),
            driverTextLabel.topAnchor.constraint(equalTo: topAnchor),
            
            carLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            carLabel.topAnchor.constraint(equalTo: driverLabel.bottomAnchor, constant: 5),
            carTextLabel.leadingAnchor.constraint(equalTo: carLabel.trailingAnchor, constant: 3),
            carTextLabel.topAnchor.constraint(equalTo: driverTextLabel.bottomAnchor, constant: 5),
            
            carNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            carNumberLabel.topAnchor.constraint(equalTo: carLabel.bottomAnchor, constant: 5),
            carNumberTextLabel.leadingAnchor.constraint(equalTo: carNumberLabel.trailingAnchor, constant: 3),
            carNumberTextLabel.topAnchor.constraint(equalTo: carTextLabel.bottomAnchor, constant: 5),
            
            travelTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            travelTimeLabel.topAnchor.constraint(equalTo: carNumberLabel.bottomAnchor, constant: 5),
            travelTimeTextLabel.leadingAnchor.constraint(equalTo: travelTimeLabel.trailingAnchor, constant: 3),
            travelTimeTextLabel.topAnchor.constraint(equalTo: carNumberTextLabel.bottomAnchor, constant: 5),
        ])
    }
}
