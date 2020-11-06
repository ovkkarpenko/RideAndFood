//
//  PromoCodeCardCell.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 04.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class PromoCodeCardCell: UITableViewCell {
    
    // MARK: - UI
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorHelper.background.color()
        view.layer.cornerRadius = 15
        view.layer.shadowColor = ColorHelper.shadow.color()?.cgColor
        view.layer.shadowOpacity = 0.07
        view.layer.shadowRadius = 5
        view.addSubview(promoCodeLabel)
        view.addSubview(titleLabel)
        view.addSubview(bottomView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var promoCodeLabel: UILabel = {
        let label = UILabel()
        label.font = FontHelper.regular12.font()
        label.textColor = ColorHelper.secondaryText.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorHelper.controlBackground.color()
        view.addSubview(statusImageView)
        view.addSubview(statusLabel)
        view.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorHelper.secondaryText.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let margin: CGFloat = 25
    private let padding: CGFloat = 15
    private let smallPadding: CGFloat = 5
    private let statusImageViewSize: CGFloat = 14
    
    // MARK: - Public properties
    
    var model: PromoCodeCellModel? {
        didSet{
            setupModel()
        }
    }
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    // MARK: - Lifecycle methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView?.image = nil
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        backgroundColor = .clear
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: margin / 2),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin / 2),
            promoCodeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            promoCodeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            promoCodeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.topAnchor.constraint(equalTo: promoCodeLabel.bottomAnchor, constant: smallPadding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            bottomView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            statusImageView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: padding),
            statusImageView.centerYAnchor.constraint(equalTo: statusLabel.centerYAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: statusImageView.trailingAnchor, constant: smallPadding),
            statusLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: smallPadding),
            statusLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -padding),
            statusLabel.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -smallPadding),
            statusImageView.heightAnchor.constraint(equalTo: statusImageView.widthAnchor),
            statusImageView.widthAnchor.constraint(equalToConstant: statusImageViewSize)
        ])
    }
    
    private func setupModel() {
        guard let model = model else { return }
        
        promoCodeLabel.text = model.code
        titleLabel.text = model.title
        
        let expiredInString = NSMutableAttributedString(string: "\(model.statusDescription): ", attributes: [.font: FontHelper.regular12.font() as Any])
        expiredInString.append(NSAttributedString(string: model.statusTime, attributes: [.font : FontHelper.semibold12.font() as Any]))
        statusLabel.attributedText = expiredInString
        statusImageView.image = model.icon
    }
}
