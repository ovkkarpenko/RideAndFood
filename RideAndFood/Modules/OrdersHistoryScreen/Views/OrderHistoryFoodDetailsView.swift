//
//  OrderHistoryFoodDetailsView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 29.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class OrderHistoryFoodDetailsView: UIView, DetailsViewProtocol {
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var destinationView: FoodDestinationView = {
        let view = FoodDestinationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var infoView: FoodInfoView = {
        let view = FoodInfoView()
        view.backgroundColor = ColorHelper.controlBackground.color()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let image = UIImage(named: "packet")
        let imageView = UIImageView(image: image)
        imageView.layer.zPosition = 10
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var createdAtLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var serviceTypeLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorHelper.secondaryText.color()
        label.font = .systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorHelper.secondaryText.color()
        label.font = .systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var paymentIdLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorHelper.secondaryText.color()
        label.font = .systemFont(ofSize: 10)
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
    
    private lazy var imageViewTrailingAnchorConstraint = imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    private lazy var imageViewBottomAnchorConstraint = imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    private lazy var imageViewToPriceLabelBottomAnchorConstraint = imageView.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: -padding)
    private lazy var priceLabelBottomAnchorConstraint = priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
    
    private func setupUI() {
        addSubview(contentView)
        contentView.addSubview(createdAtLabel)
        contentView.addSubview(serviceTypeLabel)
        contentView.addSubview(typeLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            createdAtLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            createdAtLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            
            serviceTypeLabel.leadingAnchor.constraint(equalTo: createdAtLabel.trailingAnchor),
            serviceTypeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            
            typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            typeLabel.topAnchor.constraint(equalTo: createdAtLabel.bottomAnchor, constant: 5),
            
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            priceLabelBottomAnchorConstraint,
            
            imageViewTrailingAnchorConstraint,
            imageViewBottomAnchorConstraint
        ])
    }
    
    func configure(order: OrderHistoryModel) {
        let date = NSDate(timeIntervalSince1970: Double(order.createdAt))
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM, HH:mm"
        
        createdAtLabel.text = formatter.string(from: date as Date)
        priceLabel.text = "\(order.price) \(OrdersHistoryStrings.rub.text())"
        typeLabel.text = OrdersHistoryStrings.food.text()
        serviceTypeLabel.text = OrdersHistoryStrings.foodService.text()
        paymentIdLabel.text = OrdersHistoryStrings.paymentId(order.id).text()
        destinationView.shopTextLabel.text = order.products?.first?.name
        destinationView.courierTextLabel.text = order.courier?.first?.name
        destinationView.toTextLabel.text = order.to
        infoView.productsTextLabel.text = order.products?.reduce("") { value, item in value.isEmpty ? item.name : "\(value) • \(item.name)" }
    }
    
    func expand(with animation: (() -> ())? = nil) {
        contentView.addSubview(destinationView)
        contentView.addSubview(infoView)
        contentView.addSubview(paymentIdLabel)
        imageView.image = UIImage(named: "packet-large")
        
        layoutSubviews()
        
        priceLabelBottomAnchorConstraint.isActive = false
        priceLabel.textColor = .black
        
        NSLayoutConstraint.activate([
            destinationView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            destinationView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            destinationView.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 10),
            destinationView.heightAnchor.constraint(equalToConstant: 70),
            
            infoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            infoView.topAnchor.constraint(equalTo: destinationView.bottomAnchor, constant: 10),
            infoView.heightAnchor.constraint(equalToConstant: 151),
            
            priceLabel.bottomAnchor.constraint(equalTo: paymentIdLabel.topAnchor, constant: -5),
            
            paymentIdLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            paymentIdLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
        
        UIView.animate(withDuration: 0.15, animations: {
            animation?()
            self.layoutIfNeeded()
        })
    }
    
    func shrink(with animation: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        imageView.image = UIImage(named: "packet")
        
        imageViewTrailingAnchorConstraint.constant = -padding
        imageViewToPriceLabelBottomAnchorConstraint.isActive = false
        priceLabelBottomAnchorConstraint.isActive = true
        imageViewBottomAnchorConstraint.isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding).isActive = true
        
        UIView.animate(withDuration: 0.1, animations: {
            self.destinationView.alpha = 0
            self.infoView.alpha = 0
            self.paymentIdLabel.alpha = 0
            self.layoutIfNeeded()
            animation?()
        }, completion: { _ in
            
            UIView.animate(withDuration: 0.1) {
                self.alpha = 0
            } completion: { _ in
                completion?()
            }
        })
    }
}
