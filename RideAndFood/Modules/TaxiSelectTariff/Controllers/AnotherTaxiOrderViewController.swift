//
//  AnotherTaxiOrderViewController.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 18.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class AnotherTaxiOrderViewController: UIViewController {

    var dismissCallback: (() -> ())?
    
    private let padding: CGFloat = 20
    
    private let backgroundImageView: UIImageView = {
        let image = UIImage(named: "PromocodeSuccess")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = UIColor(red: 0.204, green: 0.78, blue: 0.349, alpha: 1)
        label.text = SelectTariffStrings.continueSearchOrderTitle.text()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 4
        label.font = .systemFont(ofSize: 17)
        label.textColor = ColorHelper.secondaryText.color()
        label.text = SelectTariffStrings.continueSearchOrderDescription.text()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var confirmButton: PrimaryButton = {
        let button = PrimaryButton(title: SelectTariffStrings.good.text())
        button.addTarget(self, action: #selector(confirmButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = SelectTariffStrings.continueSearchOrderControllerTitle.text()
        navigationController?.navigationBar.topItem?.backBarButtonItem?.title = " "
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(backgroundImageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 10),
            titleLabel.widthAnchor.constraint(equalToConstant: 250),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 250),
            
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            confirmButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
        ])
        
        view.backgroundColor = .white
    }
    
    @objc private func confirmButtonPressed() {
        dismiss(animated: true)
        dismissCallback?()
    }
}
