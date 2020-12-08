//
//  MapCardView.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 27.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class MapCardView: UIView {
    
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
    
    private lazy var taxiButton: ServiceButtonView = {
        let button = ServiceButtonView()
        button.bgImage = UIImage(named: "TaxiButton")
        button.title = MapStrings.taxi.text()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var foodButton: ServiceButtonView = {
        let button = ServiceButtonView()
        button.bgImage = UIImage(named: "FoodButton")
        button.title = MapStrings.food.text()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [taxiButton, foodButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        return stackView
    }()

    private lazy var addressStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [locationImageView, addressLabel])
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [addressStackView, buttonsStackView])
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = verticalPadding
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var bottomConstraint = verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -verticalPadding)
    
    private let horizontalPadding: CGFloat = 25
    private let verticalPadding: CGFloat = 20
    
    private let emptyText = "..."
    
    // MARK: - Public properties
    
    var bottomPadding: CGFloat {
        get {
           bottomConstraint.constant
        }
        set {
            bottomConstraint.constant = -(verticalPadding + newValue)
        }
    }
    
    var taxiAction: (() -> Void)? {
        didSet {
            if let action = taxiAction {
                taxiButton.action = action
                // should change button state
            }
        }
    }
    
    var foodAction: (() -> Void)? {
        didSet {
            if let action = foodAction {
                foodButton.action = action
                // should change button state
            }
        }
    }
    
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
    
    var isTaxiButtonEnable: Bool? {
        didSet {
            if isTaxiButtonEnable! {
                taxiButton.isUserInteractionEnabled = true
                taxiButton.bgImage = UIImage(named: CustomImagesNames.taxiButton.rawValue)
            } else {
                taxiButton.isUserInteractionEnabled = false
                taxiButton.bgImage = UIImage(named: CustomImagesNames.disableTaxiButton.rawValue)
            }
        }
    }
    
    func updateTexts() {
        taxiButton.title = MapStrings.taxi.text()
        foodButton.title = MapStrings.food.text()
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

        addSubview(verticalStackView)

        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: horizontalPadding),
            verticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: verticalPadding),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -horizontalPadding),
            bottomConstraint
        ])
        layer.shadowColor = ColorHelper.shadow.color()?.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
    }
}
