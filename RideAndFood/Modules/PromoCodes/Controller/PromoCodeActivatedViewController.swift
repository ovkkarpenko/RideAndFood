//
//  PromoCodeActivatedViewController.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 04.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class PromoCodeActivatedViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var successImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "PromoCodeSuccess"))
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontHelper.semibold17.font()
        label.textColor = ColorHelper.success.color()
        label.text = PromoCodesStrings.promoCodeActivated.text()
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorHelper.secondaryText.color()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var confirmButton: PrimaryButton = {
        let button = PrimaryButton(title: StringsHelper.great.text())
        button.addTarget(self, action: #selector(confirmButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let padding: CGFloat = 35
    private let buttonPadding: CGFloat = 25
    
    // MARK: - Public properties
    
    var descriptionText: String? {
        didSet {
            descriptionLabel.text = descriptionText
        }
    }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        view.backgroundColor = ColorHelper.secondaryBackground.color()
        let stackView = UIStackView(arrangedSubviews: [successImageView, titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 11
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        view.addSubview(confirmButton)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -padding),
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            confirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
    }
    
    @objc private func confirmButtonPressed() {
        navigationController?.popToRootViewController(animated: true)
    }
}

