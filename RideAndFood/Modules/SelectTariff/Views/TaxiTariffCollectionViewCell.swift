//
//  TaxiTariffCollectionViewCell.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 04.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class TaxiTariffCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "TaxiTariffCell"
    
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
    
    private lazy var tariffTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorHelper.secondaryText.color()
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var carImaveView: UIImageView = {
        let image = UIImage(named: "tariff-car")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var tripDurationLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorHelper.secondaryText.color()
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tripPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
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
    
    private let padding: CGFloat = 15
    
    private func setupUI() {
        addSubview(backgroundShadow)
        addSubview(tariffTitleLabel)
        addSubview(carImaveView)
        addSubview(tripDurationLabel)
        addSubview(tripPriceLabel)
        
        NSLayoutConstraint.activate([
            backgroundShadow.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3),
            backgroundShadow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3),
            backgroundShadow.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            backgroundShadow.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3),
            
            tariffTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            tariffTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: padding),
            tariffTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            
            carImaveView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            carImaveView.topAnchor.constraint(equalTo: tariffTitleLabel.bottomAnchor, constant: 5),
            carImaveView.widthAnchor.constraint(equalToConstant: 15),
            carImaveView.heightAnchor.constraint(equalToConstant: 11),
            
            tripDurationLabel.leadingAnchor.constraint(equalTo: carImaveView.trailingAnchor, constant: 5),
            tripDurationLabel.topAnchor.constraint(equalTo: tariffTitleLabel.bottomAnchor, constant: 3),
            
            tripPriceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            tripPriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            tripPriceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
        
        layer.cornerRadius = 15
    }
    
    func configurate(tariff: TariffModel) {
        if tariff.id == 1 {
            carImaveView.image = UIImage(named: "tariff-car-green")
            tripDurationLabel.textColor = UIColor(red: 0.6, green: 0.8, blue: 0.2, alpha: 1)
        } else if tariff.id == 2 {
            backgroundShadow.isHidden = true
            tripPriceLabel.textColor = ColorHelper.secondaryText.color()
            backgroundColor = UIColor(red: 0.942, green: 0.942, blue: 0.942, alpha: 1)
        } else if tariff.id == 3 {
            backgroundShadow.isHidden = true
            carImaveView.image = UIImage(named: "tariff-rocket")
            tripPriceLabel.textColor = ColorHelper.secondaryText.color()
            backgroundColor = UIColor(red: 0.942, green: 0.942, blue: 0.942, alpha: 1)
        }
        
        tariffTitleLabel.text = tariff.name
        tripDurationLabel.text = "3 мин"
        tripPriceLabel.text = "100 руб"
    }
}
