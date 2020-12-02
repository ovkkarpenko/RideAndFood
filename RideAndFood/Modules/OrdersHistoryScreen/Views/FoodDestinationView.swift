//
//  FoodDestinationView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 01.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class FoodDestinationView: UIView {
    
    private lazy var shopLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorHelper.secondaryText.color()
        label.text = OrdersHistoryStrings.shopLabel.text()
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var shopTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var courierLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorHelper.secondaryText.color()
        label.text = OrdersHistoryStrings.courierLabel.text()
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var courierTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var toLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.text = OrdersHistoryStrings.toLabel.text()
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var toTextLabel: UILabel = {
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
        addSubview(shopLabel)
        addSubview(shopTextLabel)
        addSubview(courierLabel)
        addSubview(courierTextLabel)
        addSubview(toLabel)
        addSubview(toTextLabel)
        
        NSLayoutConstraint.activate([
            shopLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            shopLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            shopTextLabel.leadingAnchor.constraint(equalTo: shopLabel.trailingAnchor, constant: 3),
            shopTextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            
            courierLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            courierLabel.topAnchor.constraint(equalTo: shopLabel.bottomAnchor, constant: 6),
            courierTextLabel.leadingAnchor.constraint(equalTo: courierLabel.trailingAnchor, constant: 3),
            courierTextLabel.topAnchor.constraint(equalTo: shopTextLabel.bottomAnchor, constant: 6),
            
            toLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            toLabel.topAnchor.constraint(equalTo: courierLabel.bottomAnchor, constant: 5),
            toTextLabel.leadingAnchor.constraint(equalTo: toLabel.trailingAnchor, constant: 3),
            toTextLabel.topAnchor.constraint(equalTo: courierTextLabel.bottomAnchor, constant: 5),
        ])
    }
}
