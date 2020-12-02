//
//  ProductDetailsView.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 29.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class ProductDetailsView: UIView {
    
    // MARK: - UI
    
    private lazy var productImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "CloseButton"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = FontHelper.semibold17.font()
        return label
    }()
    
    private lazy var compositionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var producerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var detailsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            nameLabel,
            compositionLabel,
            producerLabel,
            countryLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = padding
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var counterView: CounterView = {
        let counterView = CounterView()
        counterView.setContentHuggingPriority(.defaultHigh,
                                              for: .horizontal)
        return counterView
    }()
    private lazy var addToCartButton: PrimaryButton = {
        let button = PrimaryButton(title: ProductDetailsStrings.addToCard.text())
        button.addTarget(self, action: #selector(addToCardButtonPressed), for: .touchUpInside)
        button.titleLabel?.numberOfLines = 0
        button.titleEdgeInsets = .init(top: padding, left: padding, bottom: padding, right: padding)
        button.setContentCompressionResistancePriority(.defaultHigh,
                                                       for: .horizontal)
        return button
    }()
    private lazy var addToCardStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            counterView,
            addToCartButton
        ])
        stackView.spacing = padding
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let topPadding: CGFloat = 20
    private let productImageViewMargin: CGFloat = 40
    private let closeButtonTrailingMargin: CGFloat = 25
    private let detailsStackViewVerticalMargin: CGFloat = 28
    private let padding: CGFloat = 15
    
    // MARK: - Private properties
    
    private var closeBlock: (() -> Void)?
    
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
        addSubview(productImageView)
        addSubview(closeButton)
        addSubview(detailsStackView)
        addSubview(addToCardStackView)
        
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: productImageViewMargin),
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: topPadding),
            productImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -productImageViewMargin),
            productImageView.heightAnchor.constraint(equalTo: productImageView.widthAnchor),
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: topPadding),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -closeButtonTrailingMargin),
            detailsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            detailsStackView.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: detailsStackViewVerticalMargin),
            detailsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -padding),
            detailsStackView.bottomAnchor.constraint(equalTo: addToCardStackView.topAnchor, constant: -detailsStackViewVerticalMargin),
            addToCardStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            addToCardStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            addToCardStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
    }
    
    @objc private func addToCardButtonPressed() {
        print(counterView.count)
    }
    
    @objc private func closeButtonPressed() {
        closeBlock?()
    }
}

// MARK: - ConfigurableView

extension ProductDetailsView: IConfigurableView {
    
    func configure(with model: ProductDetailModel) {
        counterView.count = 1
        addToCartButton.setAttributedTitle(nil, for: .normal)
        if let imageUrl = model.imageUrl {
            productImageView.imageByUrl(from: imageUrl)
        }
        nameLabel.text = model.name
        compositionLabel.attributedText = model.composition
        producerLabel.attributedText = model.producer
        countryLabel.attributedText = model.country
        let price = "\(model.price) \(StringsHelper.rub.text())"
        let addToCart = ProductDetailsStrings.addToCard.text()
        let text = "\(addToCart)\n\(price)"

        let attributedString = NSMutableAttributedString(string: text)
        let p1 = NSMutableParagraphStyle()
        let p2 = NSMutableParagraphStyle()
        p1.alignment = .left
        p2.alignment = .right
        p2.paragraphSpacingBefore = -(addToCartButton.titleLabel?.font.lineHeight ?? 0)
        attributedString.addAttribute(.paragraphStyle,
                                      value: p1,
                                      range: .init(location: 0,
                                                   length: addToCart.count))
        attributedString.addAttributes([.paragraphStyle: p2,
                                        .font: FontHelper.semibold17.font() as Any],
                                       range: .init(location: addToCart.count,
                                                    length: price.count + 1))
        addToCartButton.setAttributedTitle(attributedString, for: .normal)
        closeBlock = model.closeBlock
    }
}
