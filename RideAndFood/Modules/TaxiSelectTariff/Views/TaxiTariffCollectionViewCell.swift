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
    
    var tariff: TariffModel?
    
    private lazy var backgroundShadow: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0
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
    
    private lazy var tripSalePriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tripPriceLabel: UILabel = {
        let label = UILabel()
        label.attributedText = "100 руб".strikethrough("100 руб")
        label.font = .systemFont(ofSize: 10)
        label.textColor = ColorHelper.secondaryText.color()
        label.isHidden = true
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
        addSubview(tripSalePriceLabel)
        
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
            tripPriceLabel.bottomAnchor.constraint(equalTo: tripSalePriceLabel.topAnchor, constant: 5),
            
            tripSalePriceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            tripSalePriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            tripSalePriceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        layer.cornerRadius = 15
    }
    
    func configurate(tariff: TariffModel) {
        self.tariff = tariff
        
        if tariff.id == 1 {
            backgroundShadow.alpha = 1
            carImaveView.image = UIImage(named: "tariff-car-green")
            tripDurationLabel.textColor = UIColor(red: 0.6, green: 0.8, blue: 0.2, alpha: 1)
        } else if tariff.id == 2 {
            backgroundShadow.alpha = 0
            tripSalePriceLabel.textColor = ColorHelper.secondaryText.color()
            backgroundColor = UIColor(red: 0.942, green: 0.942, blue: 0.942, alpha: 1)
        } else if tariff.id == 3 {
            backgroundShadow.alpha = 0
            carImaveView.image = UIImage(named: "tariff-rocket")
            tripSalePriceLabel.textColor = ColorHelper.secondaryText.color()
            backgroundColor = UIColor(red: 0.942, green: 0.942, blue: 0.942, alpha: 1)
        }
        
        tariffTitleLabel.text = tariff.name
        tripDurationLabel.text = "3 мин"
        tripSalePriceLabel.text = "100 руб"
    }
    
    func setStatus(_ active: Bool) {
        if active {
            UIView.animate(
                withDuration: ConstantsHelper.baseAnimationDuration.value(),
                delay: 0,
                options: .curveEaseOut,
                animations: { [weak self] in
                self?.showCell()
            })
        } else {
            UIView.animate(
                withDuration: ConstantsHelper.baseAnimationDuration.value(),
                delay: 0,
                options: .curveEaseIn,
                animations: { [weak self] in
                self?.hideCell()
            })
        }
    }
    
    private func showCell() {
        guard let tariff = tariff else { return }
        if tariff.id == 1 {
            backgroundShadow.alpha = 1
            carImaveView.image = UIImage(named: "tariff-car-green")
            tripDurationLabel.textColor = UIColor(red: 0.6, green: 0.8, blue: 0.2, alpha: 1)
            tripSalePriceLabel.textColor = .black
            backgroundColor = .white
        } else if tariff.id == 2 {
            backgroundShadow.alpha = 1
            carImaveView.image = UIImage(named: "tariff-car-purple")
            tripDurationLabel.textColor = UIColor(red: 0.77, green: 0.257, blue: 0.95, alpha: 1)
            tripSalePriceLabel.textColor = .black
            backgroundColor = .white
        } else if tariff.id == 3 {
            backgroundShadow.alpha = 1
            carImaveView.image = UIImage(named: "tariff-rocket-gold")
            tripDurationLabel.textColor = UIColor(red: 0.831, green: 0.741, blue: 0.502, alpha: 1)
            tripSalePriceLabel.textColor = .black
            backgroundColor = .white
        }
    }
    
    private func hideCell() {
        guard let tariff = tariff else { return }
        if tariff.id == 1 || tariff.id == 2 {
            backgroundShadow.alpha = 0
            carImaveView.image = UIImage(named: "tariff-car")
            tripDurationLabel.textColor = ColorHelper.secondaryText.color()
            tripSalePriceLabel.textColor = ColorHelper.secondaryText.color()
            backgroundColor = UIColor(red: 0.942, green: 0.942, blue: 0.942, alpha: 1)
        } else if tariff.id == 3 {
            backgroundShadow.alpha = 0
            carImaveView.image = UIImage(named: "tariff-rocket")
            tripDurationLabel.textColor = ColorHelper.secondaryText.color()
            tripSalePriceLabel.textColor = ColorHelper.secondaryText.color()
            backgroundColor = UIColor(red: 0.942, green: 0.942, blue: 0.942, alpha: 1)
        }
    }
}
