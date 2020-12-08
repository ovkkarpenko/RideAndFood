//
//  LookingForDriverView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 08.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class LookingForDriverView: UIView, CustromViewProtocol {
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorHelper.background.color()
        view.layer.shadowColor = ColorHelper.shadow.color()?.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 10
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var searchImageView: UIImageView = {
        let image = UIImage(named: "search")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = SelectTariffStrings.lookingForDriver.text()
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.983, green: 0.556, blue: 0.315, alpha: 1)
        label.font = .systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cencelButton: PrimaryButton = {
        let button = PrimaryButton(title: PaymentStrings.celncelButtonTitle.text())
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private let padding: CGFloat = 20
    private let offset: CGFloat = UIScreen.main.bounds.height-140
    private let screenHeight = UIScreen.main.bounds.height
    
    private lazy var contentViewTopAnchorConstraint = contentView.topAnchor.constraint(equalTo: topAnchor, constant: screenHeight+offset)
    private lazy var contentViewBottomAnchorConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -screenHeight-offset)
    
    private func setupUI() {
        addSubview(contentView)
        contentView.addSubview(searchImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(cencelButton)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentViewTopAnchorConstraint,
            contentViewBottomAnchorConstraint,
            
            searchImageView.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -5),
            searchImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 30),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            
            cencelButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            cencelButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            cencelButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
        ])
    }
    
    func show() {
        contentViewTopAnchorConstraint.constant = offset
        contentViewBottomAnchorConstraint.constant = 0
        
        UIView.animate(withDuration: generalAnimationDuration, delay: 0, options: [.curveEaseOut]) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
    
    func dismiss(_ completion: (() -> ())?) {
        contentViewTopAnchorConstraint.constant = screenHeight+offset
        contentViewBottomAnchorConstraint.constant = -screenHeight-offset
        
        UIView.animate(withDuration: generalAnimationDuration, delay: 0, options: [.curveEaseIn]) { [weak self] in
            self?.layoutIfNeeded()
        } completion: { _ in
            completion?()
        }
    }
}
