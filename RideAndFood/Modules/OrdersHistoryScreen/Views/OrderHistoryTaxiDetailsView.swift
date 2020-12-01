//
//  OrderHistoryTaxiDetailsView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 29.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class OrderHistoryTaxiDetailsView: UIView, DetailsViewProtocol {
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tariffView: UIView = {
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
        
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 57),
            view.heightAnchor.constraint(equalToConstant: 20),
            
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        return view
    }()
    
    private lazy var destinationView: TaxiDestinationView = {
        let view = TaxiDestinationView()
        view.backgroundColor = ColorHelper.controlBackground.color()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var infoView: TaxiInfoView = {
        let view = TaxiInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let image = UIImage(named: "car")
        let imageView = UIImageView(image: image)
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
    
    private lazy var imageViewLeadingAnchorConstraint = imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding*2)
    private lazy var imageViewTrailingAnchorConstraint = imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
    private lazy var imageViewBottomAnchorConstraint = imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
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
        typeLabel.text = OrdersHistoryStrings.taxi.text()
        serviceTypeLabel.text = OrdersHistoryStrings.taxiService.text()
        paymentIdLabel.text = OrdersHistoryStrings.paymentId(order.id).text()
        (tariffView.subviews[0] as? UILabel)?.text = order.tariff?.name
        destinationView.fromTextLabel.text = order.from
        destinationView.toTextLabel.text = order.to
        infoView.driverTextLabel.text = order.taxi?.first?.driver
        infoView.carTextLabel.text = order.taxi?.first?.car
        infoView.carNumberTextLabel.text = order.taxi?.first?.number
        infoView.travelTimeTextLabel.text = OrdersHistoryStrings.minutes(order.distance).text()
    }
    
    func expand(with animation: (() -> ())? = nil) {
        contentView.addSubview(tariffView)
        contentView.addSubview(destinationView)
        contentView.addSubview(infoView)
        contentView.addSubview(paymentIdLabel)
        imageView.image = UIImage(named: "car-large")
        
        layoutSubviews()
        
        imageViewBottomAnchorConstraint.isActive = false
        priceLabelBottomAnchorConstraint.isActive = false
        imageViewTrailingAnchorConstraint.constant = -padding*2
        priceLabel.textColor = .black
        
        NSLayoutConstraint.activate([
            tariffView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            tariffView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            
            destinationView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            destinationView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            destinationView.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 10),
            destinationView.heightAnchor.constraint(equalToConstant: 46),
            
            infoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            infoView.topAnchor.constraint(equalTo: destinationView.bottomAnchor, constant: 10),
            infoView.heightAnchor.constraint(equalToConstant: 70),
            
            imageViewLeadingAnchorConstraint,
            imageViewToPriceLabelBottomAnchorConstraint,
            
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
        imageView.image = UIImage(named: "car")
        
        imageViewTrailingAnchorConstraint.constant = -padding
        imageViewLeadingAnchorConstraint.isActive = false
        imageViewToPriceLabelBottomAnchorConstraint.isActive = false
        priceLabelBottomAnchorConstraint.isActive = true
        imageViewBottomAnchorConstraint.isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding).isActive = true
        
        UIView.animate(withDuration: 0.1, animations: {
            self.destinationView.alpha = 0
            self.infoView.alpha = 0
            self.paymentIdLabel.alpha = 0
            self.tariffView.alpha = 0
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
