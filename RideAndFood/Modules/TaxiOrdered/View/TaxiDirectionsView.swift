//
//  TaxiDirectionsView.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 15.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class TaxiDirectionsView: UIStackView {
    
    // MARK: - UI
    
    private lazy var strokeImage = UIImageView(image: UIImage(named: "Stroke"))
    private lazy var addressFromLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorHelper.secondaryText.color()
        return label
    }()
    private lazy var addressToLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorHelper.secondaryText.color()
        return label
    }()
    private lazy var addressFromView: UIStackView = {
        let imageView = UIImageView(image: UIImage(named: "addressFromMark"))
        let stackView = UIStackView(arrangedSubviews: [imageView, addressFromLabel])
        stackView.spacing = 15
        return stackView
    }()
    private lazy var addressToView: UIStackView = {
        let imageView = UIImageView(image: UIImage(named: "addressToMark"))
        let stackView = UIStackView(arrangedSubviews: [imageView, addressToLabel])
        stackView.spacing = 15
        return stackView
    }()
    
    private lazy var carImageView = UIImageView(image: UIImage(named: "MiniCar"))
    
    private lazy var addressesStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
                                        addressFromView,
                                        addressToView])
        stackView.axis = .vertical
        stackView.spacing = 35
        return stackView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    // MARK: - Lifecycle methods
    
    // MARK: - Private methods
    
    private func setupLayout() {
        strokeImage.contentMode = .scaleAspectFit
        addArrangedSubview(strokeImage)
        addArrangedSubview(addressesStackView)
        spacing = 3
        addSubview(carImageView)
        carImageView.translatesAutoresizingMaskIntoConstraints = false
        
        carImageView.leadingAnchor.constraint(equalTo: addressFromView.arrangedSubviews[1].leadingAnchor).isActive = true
        carImageView.topAnchor.constraint(equalTo: addressFromView.bottomAnchor,
                                          constant: 10).isActive = true
    }
}

// MARK: - ConfigurableView

extension TaxiDirectionsView: IConfigurableView {
    
    func configure(with model: TaxiDirectionsViewModel) {
        addressFromLabel.text = model.addressFrom
        addressToLabel.text = model.addressTo
        carImageView.alpha = model.showCar ? 1 : 0
    }
}
