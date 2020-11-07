//
//  PaymentCongratulationsView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 06.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import Foundation
import RxSwift

class PaymentCongratulationsView: UIView {
    
    var delegate: PointsAlertDelegate?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = PaymentStrings.congratulationsAlertTitle.text()
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var titleIcon: UIImageView = {
        let icon = UIImage(named: "congratulationsIcon", in: Bundle.init(path: "Images/PaymentScreen"), with: .none)
        let imageView = UIImageView(image: icon)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, titleIcon])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var subTitleTextView: UITextView = {
        let textView = UITextView()
        textView.text = PaymentStrings.congratulationsFullTitle("10").text()
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isSelectable = false
        textView.font = .systemFont(ofSize: 17)
        textView.textAlignment = .center
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        
        let attributedString = NSMutableAttributedString(string: PaymentStrings.congratulationsFullTitle("10").text(),
                                                         attributes: [
                                                            .foregroundColor: ColorHelper.primaryText.color() as Any,
                                                            .font: FontHelper.regular17.font() as Any])
        
        attributedString.addAttribute(.foregroundColor,
                                      value: UIColor.orange,
                                      range: (attributedString.string as NSString).range(of: PaymentStrings.congratulationsPointsTitle("10").text()))
        
        attributedString.addAttribute(.paragraphStyle, value: paragraph, range: (attributedString.string as NSString).range(of: PaymentStrings.congratulationsFullTitle("10").text()))
        
        textView.attributedText = attributedString
        return textView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = PaymentStrings.congratulationsDescription.text()
        label.textColor = ColorHelper.secondaryText.color()
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var newOrderButton: PrimaryButton = {
        let button = PrimaryButton(title: PaymentStrings.newOrderButtonTitle.text())
        button.addTarget(self, action: #selector(newOrderButtomPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var detailsButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        button.setTitle(PaymentStrings.detailsButtonTitle.text(), for: .normal)
        button.setTitleColor(ColorHelper.primaryText.color(), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.addTarget(self, action: #selector(detailsButtomPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    private let padding: CGFloat = 25
    private let marginTop: CGFloat = 8
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 15
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setupLayout() {
        backgroundColor = ColorHelper.background.color()
        
        addSubview(titleStackView)
        addSubview(subTitleTextView)
        addSubview(descriptionLabel)
        addSubview(newOrderButton)
        addSubview(detailsButton)
        
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: topAnchor, constant: marginTop),
            titleStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 100),
            titleStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -100),
            
            subTitleTextView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor),
            subTitleTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            subTitleTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
            subTitleTextView.heightAnchor.constraint(equalToConstant: 30),
            
            descriptionLabel.topAnchor.constraint(equalTo: subTitleTextView.bottomAnchor, constant: marginTop),
            descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
            
            newOrderButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15),
            newOrderButton.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            newOrderButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
            
            detailsButton.topAnchor.constraint(equalTo: newOrderButton.bottomAnchor, constant: marginTop),
            detailsButton.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            detailsButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
        ])
    }
    
    @objc private func newOrderButtomPressed() {
        delegate?.newOrder()
    }
    
    @objc private func detailsButtomPressed() {
        delegate?.details()
    }
}
