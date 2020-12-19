//
//  TaxiTripInfoView.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 18.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class TaxiTripInfoView: UIView {
    
    // MARK: - UI
    
    private lazy var directionsView = TaxiDirectionsView()
    private lazy var tripTimeLabel = UILabel()
    
    private lazy var tripTimeView: UIView = {
        let view = UIView()
        tripTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tripTimeLabel)
        
        NSLayoutConstraint.activate([
            tripTimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                   constant: horizontalPadding),
            tripTimeLabel.topAnchor.constraint(equalTo: view.topAnchor,
                                               constant: 11),
            tripTimeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                    constant: -horizontalPadding),
            tripTimeLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                  constant: -11)
        ])
        view.backgroundColor = ColorHelper.controlBackground.color()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var carNameLabel = UILabel()
    private lazy var carNumberView: UIView = {
        let view = CarNumberView(number: "К 009 РВ", regionNumber: "779")
        let carNumberView = view.subviews.first?.subviews.first ?? view
        carNumberView.backgroundColor = ColorHelper.controlBackground.color()
        return carNumberView
    }()
    private lazy var driverNameLabel = UILabel()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [carNameLabel, carNumberView, driverNameLabel])
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var buttonsStackView = ButtonsStackView()
    
    private let spacing: CGFloat = 20
    private let horizontalPadding: CGFloat = 25
    
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
        directionsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(directionsView)
        addSubview(tripTimeView)
        addSubview(labelsStackView)
        addSubview(buttonsStackView)
        
        NSLayoutConstraint.activate([
            directionsView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                    constant: 10),
            directionsView.topAnchor.constraint(equalTo: topAnchor),
            directionsView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor,
                                                     constant: -horizontalPadding),
            tripTimeView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tripTimeView.topAnchor.constraint(equalTo: directionsView.bottomAnchor,
                                                  constant: spacing),
            tripTimeView.trailingAnchor.constraint(equalTo: trailingAnchor),
            labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                     constant: horizontalPadding),
            labelsStackView.topAnchor.constraint(equalTo: tripTimeView.bottomAnchor,
                                                 constant: spacing),
            labelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                      constant: -horizontalPadding),
            buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                      constant: horizontalPadding),
            buttonsStackView.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor,
                                                  constant: spacing),
            buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                       constant: -horizontalPadding),
            buttonsStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - ConfigurableView

extension TaxiTripInfoView: IConfigurableView {
    
    func configure(with model: TaxiTripInfoViewModel) {
        directionsView.configure(with: .init(addressFrom: model.addressFrom,
                                             addressTo: model.addressTo))
        
        let remainingTripTime = TaxiStrings.remainingTripTime.text()
        let tripTime = "≈\(model.tripTimeInMinutes) \(StringsHelper.minutes.text())"
        let timeText = NSMutableAttributedString(string: "\(remainingTripTime) \(tripTime)")
        timeText.addAttributes([.foregroundColor: ColorHelper.notification.color() as Any,
                                .font: FontHelper.semibold17.font() as Any],
                               range: .init(location: remainingTripTime.count + 1,
                                            length: tripTime.count))
        tripTimeLabel.attributedText = timeText
        
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
        
        carNameLabel.text = model.carName
        
        buttonsStackView.configure(with: .init(primaryTitle: ActiveTaxiOrderStrings.addDelivery.getString(),
                                               secondaryTitle: ActiveTaxiOrderStrings.reportProblem.getString(),
                                               primaryButtonPressedBlock: model.primaryButtonPressedBlock,
                                               secondaryButtonPressedBlock: model.secondaryButtonPressedBlock))
    }
}

struct TaxiTripInfoViewModel {
    let addressFrom: String
    let addressTo: String
    let driverName: String
    let carName: String
    let tripTimeInMinutes: Int
    let primaryButtonPressedBlock: () -> Void
    let secondaryButtonPressedBlock: () -> Void
}
