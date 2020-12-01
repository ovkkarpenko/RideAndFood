//
//  FoodInfoView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 01.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class FoodInfoView: UIView {
    
    private lazy var orderListLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.text = OrdersHistoryStrings.orderList.text()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var productsTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 6
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
        addSubview(orderListLabel)
        addSubview(productsTextLabel)
        
        NSLayoutConstraint.activate([
            orderListLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            orderListLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            productsTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            productsTextLabel.topAnchor.constraint(equalTo: orderListLabel.bottomAnchor, constant: 5),
            productsTextLabel.widthAnchor.constraint(equalToConstant: 169)
        ])
    }
}
