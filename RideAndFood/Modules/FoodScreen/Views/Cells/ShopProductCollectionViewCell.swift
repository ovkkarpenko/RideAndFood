//
//  ShopProductCollectionViewCell.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 22.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class ShopProductCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "ProductCell"
    
    private lazy var backgroundShadow: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = ColorHelper.shadow.color()?.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 3
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = ColorHelper.secondaryText.color()
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        addSubview(backgroundShadow)
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(weightLabel)
        
        NSLayoutConstraint.activate([
            backgroundShadow.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            backgroundShadow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            backgroundShadow.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            backgroundShadow.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding+10),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding-10),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            imageView.heightAnchor.constraint(equalToConstant: 110),
            
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding),
            
            weightLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            weightLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding),
            
        ])
    }
}
