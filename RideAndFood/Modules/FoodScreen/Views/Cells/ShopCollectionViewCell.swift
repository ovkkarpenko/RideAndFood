//
//  ShopCollectionViewCell.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 21.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class ShopCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "ShopCell"
    
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
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var imageContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageViewOffset: CGFloat = 15
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    private let padding: CGFloat = 5
    
    func setupLayout() {
        addSubview(backgroundShadow)
        addSubview(imageContainerView)
        imageContainerView.addSubview(imageView)
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            backgroundShadow.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            backgroundShadow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            backgroundShadow.topAnchor.constraint(equalTo: topAnchor, constant: padding+3),
            backgroundShadow.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            nameLabel.widthAnchor.constraint(equalToConstant: 95),
            
            imageContainerView.widthAnchor.constraint(equalTo: backgroundShadow.widthAnchor, multiplier: 0.4),
            imageContainerView.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            imageContainerView.trailingAnchor.constraint(equalTo: backgroundShadow.trailingAnchor),
            imageContainerView.bottomAnchor.constraint(equalTo: backgroundShadow.bottomAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: imageContainerView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: imageContainerView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor, constant: imageViewOffset),
            imageView.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: imageViewOffset)
        ])
    }
}
