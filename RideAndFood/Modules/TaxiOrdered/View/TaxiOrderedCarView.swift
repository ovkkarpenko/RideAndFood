//
//  TaxiOrderedCarView.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 15.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class TaxiOrderedCarView: UIView {
    
    // MARK: - UI
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontHelper.regular26.font()
        return label
    }()
    
    private lazy var classLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = FontHelper.regular10.font()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var classView: UIView = {
        let view = UIView()
        view.addSubview(classLabel)
        view.layer.cornerRadius = 10
        let horizontal: CGFloat = 10
        let vertical: CGFloat = 3
        NSLayoutConstraint.activate([
            classLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontal),
            classLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: vertical),
            classLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontal),
            classLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -vertical)
        ])
        return view
    }()
    
    private lazy var carImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var driverNameLabel = UILabel()
    private lazy var pickupTimeLabel = UILabel()
    private lazy var priceLabel = UILabel()
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            classView
        ])
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            driverNameLabel,
            pickupTimeLabel,
            priceLabel
        ])
        stackView.spacing = 6
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            topStackView,
            carImageView,
            bottomStackView
        ])
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let topPadding: CGFloat = 14
    private let horizontalPadding: CGFloat = 25
    private let bottomPadding: CGFloat = 21
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        backgroundColor = ColorHelper.controlBackground.color()
        addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                   constant: horizontalPadding),
            mainStackView.topAnchor.constraint(equalTo: topAnchor,
                                               constant: topPadding),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                    constant: -horizontalPadding),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                  constant: -bottomPadding)
        ])
    }
}

// MARK: - ConfigurableView

extension TaxiOrderedCarView: IConfigurableView {
    
    func configure(with model: TaxiOrderedCarViewModel) {
        titleLabel.text = model.carName
        classLabel.text = model.className
        classView.backgroundColor = model.classColor
        carImageView.image = model.carImage
        let driver = NSMutableAttributedString(string: "\(TaxiStrings.driver.text()): ",
                                               attributes: [
                                                .foregroundColor: ColorHelper.secondaryText.color() as Any,
                                                .font: FontHelper.regular12.font() as Any
                                               ])
        let driverName = NSAttributedString(string: model.driverName,
                                            attributes: [
                                                .foregroundColor: ColorHelper.primaryText.color() as Any,
                                                .font: FontHelper.regular12.font() as Any
                                            ])
        driver.append(driverName)
        driverNameLabel.attributedText = driver
        let pickup = NSMutableAttributedString(string: "\(TaxiStrings.pickupTime.text()): ",
                                               attributes: [
                                                .foregroundColor: ColorHelper.secondaryText.color() as Any,
                                                .font: FontHelper.regular12.font() as Any
                                               ])
        let pickupTime = NSAttributedString(string: model.pickupTime,
                                            attributes: [
                                                .foregroundColor: ColorHelper.primaryText.color() as Any,
                                                .font: FontHelper.regular12.font() as Any
                                            ])
        pickup.append(pickupTime)
        pickupTimeLabel.attributedText = pickup
        priceLabel.text = model.price
    }
}
