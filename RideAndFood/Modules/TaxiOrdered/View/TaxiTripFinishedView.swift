//
//  TaxiTripFinishedView.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 19.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class TaxiTripFinishedView: UIView {
    
    // MARK: - UI
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Success"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = FontHelper.semibold17.font()
        label.textColor = ColorHelper.success.color()
        label.text = TaxiStrings.thankForTrip.text()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = FontHelper.light17.font()
        label.textColor = ColorHelper.secondaryText.color()
        label.text = TaxiStrings.gladToSeeAgain.text()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var paymentView = PaymentView()
    
    private lazy var primaryButton = PrimaryButton(title: PaymentStrings.newOrderButtonTitle.text())
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            iconImageView,
            titleLabel,
            subTitleLabel,
            paymentView,
            primaryButton
        ])
        stackView.axis = .vertical
        stackView.setCustomSpacing(11, after: iconImageView)
        stackView.setCustomSpacing(7, after: titleLabel)
        stackView.setCustomSpacing(41, after: subTitleLabel)
        stackView.setCustomSpacing(41, after: paymentView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Private properties
    
    private var primaryButtonTappedBlock: (() -> Void)?
    
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
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func primaryButtonTapped() {
        primaryButtonTappedBlock?()
    }
}

// MARK: - ConfigurableView

extension TaxiTripFinishedView: IConfigurableView {
    
    func configure(with model: TaxiTripFinishedViewModel) {
        guard let paymentCellModel = PaymentCellModel(payment: model.payment,
                                                      padding: 0) else { return }
        paymentView.configure(with: paymentCellModel)
        primaryButton.addTarget(self, action: #selector(primaryButtonTapped), for: .touchUpInside)
        primaryButtonTappedBlock = model.primaryButtonTappedBlock
    }
}

struct TaxiTripFinishedViewModel {
    let payment: Payment
    let primaryButtonTappedBlock: () -> Void
}
