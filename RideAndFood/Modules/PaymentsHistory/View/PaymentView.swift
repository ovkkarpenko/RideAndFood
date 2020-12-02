//
//  PaymentView.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 28.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class PaymentView: UIView {
    
    // MARK: - UI
    
    private lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorHelper.background.color()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "PaymentCellBackground"))
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cardNumberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = FontHelper.regular8.font()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorHelper.secondaryText.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var cardImage: UIImage? {
        didSet {
            cardImageView.image = cardImage
        }
    }
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = FontHelper.regular10.font()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var detailsLabel: UILabel = {
        let label = UILabel()
        label.font = FontHelper.regular12.font()
        label.textColor = ColorHelper.secondaryText.color()
        label.alpha = 0
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var sendEmailButton: PrimaryButton = {
        let button = PrimaryButton()
        button.setTitle(PaymentsHistoryStrings.sendEmail.text(), for: .normal)
        button.alpha = 0
        button.heightConstraint.isActive = false
        return button
    }()
    
    private lazy var cardInfoView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            cardImageView,
            cardNumberLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = stackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var paymentInfoView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            descriptionLabel,
            titleLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = stackViewSpacing
        stackView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        stackView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let margin: CGFloat = 25
    private let padding: CGFloat = 13
    private let stackViewSpacing: CGFloat = 6
    private let imageHeight: CGFloat = 14
    
    private lazy var amountShrinkedTopConstraint =
        amountLabel.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor,
                                            constant: -padding * 2)
    private lazy var amountExpandedTopConstraint =
        amountLabel.bottomAnchor.constraint(equalTo: sendEmailButton.topAnchor,
                                            constant: -padding)
    private lazy var sendEmailHeightConstraint =
        sendEmailButton.heightAnchor.constraint(equalToConstant: 50)
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    // MARK: - Public methods
    
    func expand(with animation: (() -> Void)? = nil) {
        detailsLabel.text = PaymentsHistoryStrings.description.text()
        addSubview(detailsLabel)
        addSubview(sendEmailButton)
        
        layoutSubviews()
        
        amountShrinkedTopConstraint.isActive = false
        NSLayoutConstraint.activate([
            amountExpandedTopConstraint,
            detailsLabel.leadingAnchor.constraint(equalTo: paymentInfoView.leadingAnchor),
            detailsLabel.topAnchor.constraint(equalTo: paymentInfoView.bottomAnchor, constant: stackViewSpacing),
            detailsLabel.trailingAnchor.constraint(equalTo: cardInfoView.trailingAnchor),
            detailsLabel.bottomAnchor.constraint(equalTo: amountLabel.topAnchor, constant: -padding),
            sendEmailButton.leadingAnchor.constraint(equalTo: paymentInfoView.leadingAnchor),
            sendEmailButton.trailingAnchor.constraint(equalTo: cardInfoView.trailingAnchor),
            sendEmailButton.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor,
                                                    constant: -padding * 2),
            sendEmailHeightConstraint
        ])
        
        UIView.animate(withDuration: 0.15, animations: {
            animation?()
            self.layoutIfNeeded()
            self.amountLabel.textColor = ColorHelper.primaryText.color()
        }) { _ in
            UIView.animate(withDuration: 0.15) {
                self.detailsLabel.alpha = 1
                self.sendEmailButton.alpha = 1
            }
        }
    }
    
    func shrink(with animation: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.1, animations: {
            self.detailsLabel.alpha = 0
            self.sendEmailButton.alpha = 0
        }, completion: { _ in
            self.amountExpandedTopConstraint.isActive = false
            self.sendEmailHeightConstraint.isActive = false
            self.amountShrinkedTopConstraint.isActive = true
            self.detailsLabel.removeFromSuperview()
            self.sendEmailButton.removeFromSuperview()
            UIView.animate(withDuration: 0.2, animations: {
                self.layer.shadowOpacity = 0
                self.layoutIfNeeded()
                animation?()
            }) { _ in
                UIView.animate(withDuration: 0.1) {
                    self.alpha = 0
                } completion: { _ in
                    completion?()
                }

            }
        })
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        backgroundColor = .clear
        layer.shadowColor = ColorHelper.shadow.color()?.cgColor
        layer.shadowOpacity = 0.07
        layer.shadowRadius = 5
        addSubview(backgroundImageView)
        addSubview(bgView)
        addSubview(amountLabel)
        addSubview(paymentInfoView)
        addSubview(cardInfoView)
        
        NSLayoutConstraint.activate([
            bgView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            bgView.topAnchor.constraint(equalTo: topAnchor, constant: margin / 2),
            bgView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            bgView.bottomAnchor.constraint(equalTo: backgroundImageView.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                        constant: -margin / 2),
            paymentInfoView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: padding),
            paymentInfoView.topAnchor.constraint(equalTo: bgView.topAnchor, constant: padding),
            paymentInfoView.trailingAnchor.constraint(equalTo: cardInfoView.leadingAnchor, constant: -padding),
            cardInfoView.topAnchor.constraint(equalTo: bgView.topAnchor, constant: padding),
            cardInfoView.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: -padding),
            amountLabel.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: padding),
            amountShrinkedTopConstraint,
            amountLabel.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor,constant: -padding),
            cardImageView.heightAnchor.constraint(equalToConstant: imageHeight)
        ])
    }
}

extension PaymentView: IConfigurableView {
    func configure(with model: PaymentCellModel) {
        descriptionLabel.text = model.descriptionText
        titleLabel.text = model.paymentTitle
        amountLabel.text = model.amountText
        cardNumberLabel.text = model.cardNumber
        cardImage = model.cardImage
    }
}
