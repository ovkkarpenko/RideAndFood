//
//  ProductBreadcrumbCollectionViewCell.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 24.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class ProductBreadcrumbCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "ProductBreadcrumbCell"
    
    private lazy var background: UIView = {
        let view = UIView()
        view.backgroundColor = ColorHelper.controlBackground.color()
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = ColorHelper.secondaryText.color()
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    private let padding: CGFloat = 20
    
    func setupLayout() {
        addSubview(background)
        background.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            background.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            background.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            background.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            background.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
