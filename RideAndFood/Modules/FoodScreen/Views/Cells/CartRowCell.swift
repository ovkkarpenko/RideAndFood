//
//  CartRowCell.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 06.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class CartRowCell: UITableViewCell {
    
    // MARK: - UI
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = ColorHelper.controlBackground.color()
        label.textColor = ColorHelper.secondaryText.color()
        label.font = FontHelper.regular10.font()
        label.textAlignment = .center
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontHelper.regular12.font()
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = FontHelper.regular15.font()
        label.textColor = ColorHelper.secondaryText.color()
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            countLabel,
            titleLabel,
            priceLabel
        ])
        stackView.distribution = .fillProportionally
        stackView.spacing = 14
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let verticalPadding: CGFloat = 15
    private let horizontalPadding: CGFloat = 25
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        countLabel.layer.cornerRadius = countLabel.bounds.width / 2
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            countLabel.widthAnchor.constraint(greaterThanOrEqualTo: countLabel.heightAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                               constant: horizontalPadding),
            stackView.topAnchor.constraint(equalTo: topAnchor,
                                           constant: verticalPadding),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                constant: -horizontalPadding),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                              constant: -verticalPadding)
        ])
    }
}

// MARK: - ConfigurableView

extension CartRowCell: IConfigurableView {
    
    func configure(with model: CartRowCellModel) {
        countLabel.text = model.count
        titleLabel.text = model.title
        priceLabel.text = model.price
        layoutIfNeeded()
        layoutSubviews()
    }
}
