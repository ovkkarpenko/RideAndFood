//
//  OrderHistoryTaxiDetailsView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 29.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class OrderHistoryTaxiDetailsView: UIView {
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var tariffView: UIView = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 10)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = ColorHelper.success.color()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        return view
    }()
    
    private lazy var destinationView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorHelper.controlBackground.color()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let fromLabel = UILabel()
        fromLabel.textColor = .blue
        fromLabel.text = OrdersHistoryStrings.fromLabel.text()
        fromLabel.font = .systemFont(ofSize: 12)
        fromLabel.translatesAutoresizingMaskIntoConstraints = false
        let fromTextLabel = UILabel()
        fromTextLabel.text = "123"
        fromTextLabel.font = .systemFont(ofSize: 12)
        fromTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let toLabel = UILabel()
        toLabel.textColor = .orange
        toLabel.text = OrdersHistoryStrings.toLabel.text()
        toLabel.font = .systemFont(ofSize: 12)
        toLabel.translatesAutoresizingMaskIntoConstraints = false
        let toTextLabel = UILabel()
        toTextLabel.text = "123"
        toTextLabel.font = .systemFont(ofSize: 12)
        toTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(fromLabel)
        view.addSubview(fromTextLabel)
        view.addSubview(toLabel)
        view.addSubview(toTextLabel)
        
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 46),
            
            fromLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            fromLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            fromTextLabel.leadingAnchor.constraint(equalTo: fromLabel.trailingAnchor, constant: 3),
            fromTextLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            
            toLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            toLabel.topAnchor.constraint(equalTo: fromLabel.bottomAnchor, constant: 5),
            toTextLabel.leadingAnchor.constraint(equalTo: toLabel.trailingAnchor, constant: 3),
            toTextLabel.topAnchor.constraint(equalTo: fromTextLabel.bottomAnchor, constant: 5),
        ])
        
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let image = UIImage(named: "car")
        let imageView = UIImageView(image: image)
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
    
    lazy var paymentIdLabel: UILabel = {
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
    
    private lazy var imageViewTrailingAnchorConstraint = imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
    private lazy var imageViewBottomAnchorConstraint = imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
    private lazy var priceLabelBottomAnchorConstraint = priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
    
    
    private func setupUI() {
        addSubview(contentView)
        contentView.addSubview(createdAtLabel)
        contentView.addSubview(serviceTypeLabel)
        contentView.addSubview(destinationView)
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
            imageViewBottomAnchorConstraint,
            
            destinationView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            destinationView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            destinationView.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: padding),
        ])
    }
    
    func configure(order: OrderHistoryModel) {
        let date = NSDate(timeIntervalSince1970: Double(order.createdAt))
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM, HH:mm"
        
        createdAtLabel.text = formatter.string(from: date as Date)
        priceLabel.text = "\(order.price) \(OrdersHistoryStrings.rub.text())"
        typeLabel.text = OrdersHistoryStrings.taxi.text()
        serviceTypeLabel.text = OrdersHistoryStrings.taxiService.text()
        paymentIdLabel.text = OrdersHistoryStrings.paymentId(order.id).text()
        (tariffView.subviews[0] as? UILabel)?.text = order.tariff?.name
        (destinationView.subviews[1] as? UILabel)?.text = order.from
        (destinationView.subviews[3] as? UILabel)?.text = order.to
    }
    
    func expand(with animation: (() -> ())? = nil) {
        contentView.addSubview(tariffView)
        contentView.addSubview(paymentIdLabel)
        imageView.image = UIImage(named: "car-large")
        
        imageViewBottomAnchorConstraint.isActive = false
        priceLabelBottomAnchorConstraint.isActive = false
        imageViewTrailingAnchorConstraint.constant = -padding*2
        priceLabel.textColor = .black
        
        NSLayoutConstraint.activate([
            tariffView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            tariffView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            tariffView.widthAnchor.constraint(equalToConstant: 57),
            tariffView.heightAnchor.constraint(equalToConstant: 20),
            
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding*2),
            imageView.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: -padding),
            
            priceLabel.bottomAnchor.constraint(equalTo: paymentIdLabel.topAnchor, constant: -5),
            
            paymentIdLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            paymentIdLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
        ])
        
        UIView.animate(withDuration: 0.15, animations: {
            animation?()
            self.layoutIfNeeded()
        }) { _ in
            //            UIView.animate(withDuration: 0.15) {
            //                self.detailsLabel.alpha = 1
            //                self.sendEmailButton.alpha = 1
            //            }
        }
    }
}
