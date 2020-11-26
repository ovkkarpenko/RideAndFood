//
//  OrdersHistoryCollectionViewCell.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 26.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class OrdersHistoryCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "OrdersHistoryCell"
    
    private lazy var backgroundShadow: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = ColorHelper.shadow.color()?.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 3
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var createdAtLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var serviceTypeLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorHelper.secondaryText.color()
        label.font = .systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorHelper.secondaryText.color()
        label.font = .systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cancellationReasonLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textColor = ColorHelper.secondaryText.color()
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cancellationLabel: UILabel = {
        let label = UILabel()
        label.text = OrdersHistoryStrings.cancellationReason.text()
        label.isHidden = true
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cancellationReasonView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.backgroundColor = ColorHelper.controlBackground.color()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    lazy var imageViewBottomConstraint = imageView.bottomAnchor.constraint(equalTo: cancellationReasonView.topAnchor)
    private lazy var cancellationReasonViewHeightAnchor = cancellationReasonView.heightAnchor.constraint(equalToConstant: 0)
    
    func setupUI() {
        addSubview(backgroundShadow)
        addSubview(imageView)
        addSubview(createdAtLabel)
        addSubview(serviceTypeLabel)
        addSubview(typeLabel)
        addSubview(priceLabel)
        addSubview(cancellationReasonView)
        cancellationReasonView.addSubview(cancellationLabel)
        cancellationReasonView.addSubview(cancellationReasonLabel)
        
        NSLayoutConstraint.activate([
            backgroundShadow.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            backgroundShadow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            backgroundShadow.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            backgroundShadow.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            createdAtLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            createdAtLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            
            serviceTypeLabel.leadingAnchor.constraint(equalTo: createdAtLabel.trailingAnchor),
            serviceTypeLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            
            typeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            typeLabel.topAnchor.constraint(equalTo: createdAtLabel.bottomAnchor, constant: 5),
            
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            priceLabel.bottomAnchor.constraint(equalTo: cancellationReasonView.topAnchor, constant: -padding),
            
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            imageViewBottomConstraint,
            
            cancellationReasonView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            cancellationReasonView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            cancellationReasonView.bottomAnchor.constraint(equalTo: bottomAnchor),
            cancellationReasonViewHeightAnchor,
            
            cancellationLabel.leadingAnchor.constraint(equalTo: cancellationReasonView.leadingAnchor, constant: padding),
            cancellationLabel.centerYAnchor.constraint(equalTo: cancellationReasonView.centerYAnchor),
            
            cancellationReasonLabel.leadingAnchor.constraint(equalTo: cancellationLabel.trailingAnchor),
            cancellationReasonLabel.trailingAnchor.constraint(lessThanOrEqualTo: cancellationReasonView.trailingAnchor, constant: -padding),
            cancellationReasonLabel.centerYAnchor.constraint(equalTo: cancellationReasonView.centerYAnchor)
        ])
    }
    
    func initCanceledView(cancellationReason: String) {
        cancellationReasonLabel.text = cancellationReason
        cancellationLabel.isHidden = false
        cancellationReasonLabel.isHidden = false
        cancellationReasonViewHeightAnchor.constant = 30
    }
}
