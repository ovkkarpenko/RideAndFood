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
    
    private lazy var promoCodeActivatedView: PromoCodeActivatedView = {
        let view = PromoCodeActivatedView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
            promoCodeActivatedView.descriptionText = descriptionText
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
        view.addSubview(promoCodeActivatedView)
        view.addSubview(confirmButton)
        NSLayoutConstraint.activate([
            promoCodeActivatedView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            promoCodeActivatedView.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor),
            promoCodeActivatedView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            promoCodeActivatedView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor),
            promoCodeActivatedView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -padding),
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            confirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
    }
    
    @objc private func confirmButtonPressed() {
        navigationController?.popToRootViewController(animated: true)
    }
}

