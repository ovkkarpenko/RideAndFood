//
//  TaxiOrderDetailsView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 18.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class TaxiOrderDetailsView: UIView {
    
    private let padding: CGFloat = 20
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let carImageView: UIImageView = {
        let image = UIImage(named: "car-full")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    
    private let driverLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = ColorHelper.secondaryText.color()
        label.text = OrdersHistoryStrings.driverLabel.text()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let driverTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = ColorHelper.secondaryText.color()
        label.text = OrdersHistoryStrings.time.text()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
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
    
    func setupUI() {
        addSubview(titleLabel)
        addSubview(tariffView)
        addSubview(carImageView)
        addSubview(driverLabel)
        addSubview(driverTextLabel)
        addSubview(timeLabel)
        addSubview(timeTextLabel)
        addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: tariffView.leadingAnchor, constant: padding),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            tariffView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            tariffView.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            tariffView.widthAnchor.constraint(equalToConstant: 60),
            
            carImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            carImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding+10),
            carImageView.widthAnchor.constraint(equalToConstant: 325),
            
            driverLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            driverLabel.topAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: padding),
            driverTextLabel.leadingAnchor.constraint(equalTo: driverLabel.trailingAnchor, constant: 3),
            driverTextLabel.topAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: padding),
            
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            timeLabel.topAnchor.constraint(equalTo: driverLabel.bottomAnchor, constant: 5),
            timeTextLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 3),
            timeTextLabel.topAnchor.constraint(equalTo: driverTextLabel.bottomAnchor, constant: 5),
            
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            priceLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: padding)
        ])
        
        backgroundColor = ColorHelper.controlBackground.color()
    }
    
    func config() {
        titleLabel.text = "Белый Opel Astra"
        driverTextLabel.text = "Анатолий (id: 23-87)"
        timeTextLabel.text = "3 минуты"
        priceLabel.text = "100 \(OrdersHistoryStrings.rub.text())"
        (tariffView.subviews[0] as? UILabel)?.text = "Standart"
    }
}
