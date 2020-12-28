//
//  TaxiConfirmationView.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 15.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class TaxiConfirmationView: UIView {
    
    // MARK: - UI
    
    private lazy var tripDurationView = TripGradientDurationView()
    private lazy var directionsView = TaxiDirectionsView()
    private lazy var taxiOrderedCarView = TaxiOrderedCarView()
    private lazy var buttonsStackView = ButtonsStackView()
    
    private let spacing: CGFloat = 25
    
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
    
    // MARK: - Private methods
    
    private func setupLayout() {
        tripDurationView.translatesAutoresizingMaskIntoConstraints = false
        directionsView.translatesAutoresizingMaskIntoConstraints = false
        taxiOrderedCarView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(tripDurationView)
        addSubview(directionsView)
        addSubview(taxiOrderedCarView)
        addSubview(buttonsStackView)
        
        NSLayoutConstraint.activate([
            tripDurationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            tripDurationView.topAnchor.constraint(equalTo: topAnchor,
                                                  constant: spacing),
            directionsView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                    constant: 10),
            directionsView.topAnchor.constraint(equalTo: tripDurationView.bottomAnchor,
                                                constant: spacing),
            directionsView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor,
                                                     constant: -10),
            taxiOrderedCarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            taxiOrderedCarView.topAnchor.constraint(equalTo: directionsView.bottomAnchor,
                                                    constant: spacing),
            taxiOrderedCarView.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                      constant: spacing),
            buttonsStackView.topAnchor.constraint(equalTo: taxiOrderedCarView.bottomAnchor,
                                                  constant: spacing),
            buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                       constant: -spacing),
            buttonsStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                                       constant: -10)
        ])
    }
}

// MARK: - ConfigurableView

extension TaxiConfirmationView: IConfigurableView {
    
    func configure(with model: TaxiConfirmationViewModel) {
        directionsView.configure(with: .init(addressFrom: model.taxiOrderModel.from,
                                             addressTo: model.taxiOrderModel.to,
                                             showCar: false))
        taxiOrderedCarView.configure(with: .init(carName: model.carName,
                                                 className: model.taxiOrderModel.tariffName,
                                                 classColor: model.tariffColor,
                                                 carImage: model.taxiOrderModel.carImage,
                                                 driverName: model.taxiOrderModel.driver,
                                                 pickupTime: model.pickupTime,
                                                 price: model.price))
        buttonsStackView.configure(with: .init(primaryTitle: StringsHelper.confirm.text(),
                                               secondaryTitle: StringsHelper.cancel.text(),
                                               primaryButtonPressedBlock: model.primaryButtonPressedBlock,
                                               secondaryButtonPressedBlock: model.secondaryButtonPressedBlock))
    }
}
