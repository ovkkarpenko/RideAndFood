//
//  TaxiDestinationView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 30.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class TaxiDestinationView: UIView {
    
    private lazy var fromLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.text = OrdersHistoryStrings.fromLabel.text()
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var fromTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var toLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
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
        addSubview(fromLabel)
        addSubview(fromTextLabel)
        addSubview(toLabel)
        addSubview(toTextLabel)
        
        NSLayoutConstraint.activate([
            fromLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            fromLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            fromTextLabel.leadingAnchor.constraint(equalTo: fromLabel.trailingAnchor, constant: 3),
            fromTextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            
            toLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            toLabel.topAnchor.constraint(equalTo: fromLabel.bottomAnchor, constant: 5),
            toTextLabel.leadingAnchor.constraint(equalTo: toLabel.trailingAnchor, constant: 3),
            toTextLabel.topAnchor.constraint(equalTo: fromTextLabel.bottomAnchor, constant: 5),
        ])
    }
}
