//
//  SelectAddressView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 11.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import Foundation

class SelectAddressView: UIView {
    
    // MARK: - UI
    
    private lazy var activeLocationIcon = UIImage(named: "LocationIconActive")
    private lazy var inactiveLocationIcon = UIImage(named: "LocationIconInactive")
    private lazy var locationImageView: UIImageView = {
        let imageView = UIImageView(image: inactiveLocationIcon)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorHelper.secondaryText.color()
        label.text = emptyText
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var selectAddressButton: UIButton = {
        let button = PrimaryButton(title: AddAddressesStrings.selectAddress.text())
        button.addTarget(self, action: #selector(selectAddressButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let horizontalPadding: CGFloat = 25
    private let verticalPadding: CGFloat = 20
    
    private let emptyText = "..."
    
    // MARK: - Public properties
    
    var selectAddressCallback: ((String) -> Void)?
    
    var address: String? {
        didSet {
            if let address = address {
                locationImageView.image = activeLocationIcon
                addressLabel.text = address
                addressLabel.textColor = ColorHelper.primaryText.color()
            } else {
                locationImageView.image = inactiveLocationIcon
                addressLabel.text = emptyText
                addressLabel.textColor = ColorHelper.secondaryText.color()
            }
        }
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    // MARK: - Lifecycle methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 15
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        backgroundColor = ColorHelper.background.color()

        addSubview(locationImageView)
        addSubview(addressLabel)
        addSubview(selectAddressButton)

        NSLayoutConstraint.activate([
            locationImageView.trailingAnchor.constraint(equalTo: addressLabel.leadingAnchor, constant: -10),
            locationImageView.topAnchor.constraint(equalTo: addressLabel.topAnchor),
            
            addressLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            addressLabel.topAnchor.constraint(equalTo: topAnchor, constant: verticalPadding),
            
            selectAddressButton.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: verticalPadding),
            selectAddressButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            selectAddressButton.widthAnchor.constraint(equalToConstant: 150)
        ])
        layer.shadowColor = ColorHelper.shadow.color()?.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
    }
    
    @objc private func selectAddressButtonPressed() {
        selectAddressCallback?(address ?? "")
    }
}
