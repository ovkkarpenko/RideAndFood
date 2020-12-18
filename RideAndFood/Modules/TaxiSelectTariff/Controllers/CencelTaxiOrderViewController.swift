//
//  CencelTaxiOrderViewController.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 18.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class CencelTaxiOrderViewController: UIViewController {
    
    var dismissCallback: (() -> ())?
    
    private let padding: CGFloat = 20
    
    private let backgroundImageView: UIImageView = {
        let image = UIImage(named: "cencel-order-background")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = UIColor(red: 0.983, green: 0.556, blue: 0.315, alpha: 1)
        label.text = SelectTariffStrings.youCencelOrderTitle.text()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 4
        label.font = .systemFont(ofSize: 17)
        label.textColor = ColorHelper.secondaryText.color()
        label.text = SelectTariffStrings.youCencelOrderDescription.text()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var anotherOrderButton: PrimaryButton = {
        let button = PrimaryButton(title: SelectTariffStrings.anotherOrder.text())
        button.addTarget(self, action: #selector(anotherOrderButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var problemButton: PrimaryButton = {
        let button = PrimaryButton(title: SelectTariffStrings.problem.text())
        //        button.addTarget(self, action: #selector(otherQuantityButtonPressed), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
    }
    
    func setupUI() {
        view.addSubview(backgroundImageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(anotherOrderButton)
        view.addSubview(problemButton)
        
        NSLayoutConstraint.activate([
            backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 10),
            titleLabel.widthAnchor.constraint(equalToConstant: 250),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 250),
            
            anotherOrderButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            anotherOrderButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            anotherOrderButton.bottomAnchor.constraint(equalTo: problemButton.topAnchor),
            
            problemButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            problemButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            problemButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
        ])
        
        view.backgroundColor = .white
    }
    
    private func setupNavigationBar() {
        navigationItem.title = SelectTariffStrings.cencelTitle.text()
        navigationItem.backBarButtonItem?.tintColor = .gray
        navigationItem.leftBarButtonItem = .init(image: UIImage(named: "BackIcon"),
                                                 style: .done,
                                                 target: self,
                                                 action: #selector(dismissSelf))
    }
    
    @objc private func anotherOrderButtonPressed() {
        let vc = AnotherTaxiOrderViewController()
        vc.dismissCallback = dismissCallback
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func dismissSelf() {
        dismiss(animated: true)
        dismissCallback?()
    }
}
