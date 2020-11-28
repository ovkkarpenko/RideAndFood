//
//  FoodAddressView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 18.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import Foundation
import RxSwift

class FoodAddressView: UIView {
    
    var delegate: FoodViewDelegate?
    
    private lazy var addressIcon: UIImageView = {
        let image = UIImage(named: "LocationIconActive", in: Bundle.init(path: "Images/MapScreen"), with: .none)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var addressTextField: UITextField = {
        let textField = MaskTextField()
        textField.keyboardType = .default
        textField.placeholder = FoodSelectAddressStrings.addressTextField.text()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var showMapButton: UIStackView = {
        var leftLineLayer = CALayer()
        leftLineLayer.backgroundColor = ColorHelper.disabledButton.color()?.cgColor
        leftLineLayer.frame = CGRect(x: 5, y: -10, width: 1, height: 23)
        
        let leftLine = UIView()
        leftLine.layer.addSublayer(leftLineLayer)
        
        let button = UIButton()
        button.setTitle(AddAddressesStrings.mapButton.text(), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setTitleColor(ColorHelper.primaryText.color(), for: .normal)
        
        button.rx.tap
            .subscribe(onNext: { _ in
                
                self.delegate?.shopMap()
            }).disposed(by: bag)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(named: "rightArrow", in: Bundle.init(path: "Images/Icons"), with: .none)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 5, width: 9.5, height: 7.3)
        
        let stackView = UIStackView(arrangedSubviews: [leftLine, button, imageView])
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
//        tableView.isHidden = true
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = PrimaryButton(title: PaymentStrings.confirmButtonTitle.text())
        
        button.rx.tap
            .subscribe(onNext: { _ in
                
                if let address = self.addressTextField.text,
                   !address.isEmpty {
                    self.delegate?.showShop(address: Address(address: address))
                }
            }).disposed(by: bag)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
        setupTableView()
    }
    
    private let padding: CGFloat = 20
    private let cellIdentifier = "AddressCell"
    
    private let bag = DisposeBag()
    private let viewModel = AddressViewModel(type: .selectAddress)
    
    lazy var tableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: 165)
    
    func setupLayout() {
        addSubview(addressIcon)
        addSubview(addressTextField)
        addSubview(showMapButton)
        addSubview(tableView)
        addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            addressIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            addressIcon.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            
            addressTextField.leadingAnchor.constraint(equalTo: addressIcon.leadingAnchor, constant: padding),
            addressTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            addressTextField.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            
            showMapButton.widthAnchor.constraint(equalToConstant: 60),
            showMapButton.heightAnchor.constraint(equalToConstant: 23),
            showMapButton.topAnchor.constraint(equalTo: addressTextField.topAnchor, constant: -5),
            showMapButton.trailingAnchor.constraint(equalTo: addressTextField.trailingAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: padding),
            tableView.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: -padding),
            tableViewHeightConstraint,
            
            confirmButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            confirmButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            confirmButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: -padding),
        ])
        
        layer.shadowColor = ColorHelper.shadow.color()?.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
        layer.cornerRadius = 15
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.register(AddressTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        tableView.rx
            .modelSelected(Address.self)
            .subscribe(onNext: { [weak self] address in
                
                self?.delegate?.showShop(address: address)
            }).disposed(by: bag)
        
        viewModel.addressesPublishSubject
            .bind(to: tableView.rx.items(dataSource: viewModel.dataSource(cellIdentifier: cellIdentifier)))
            .disposed(by: bag)
        
        viewModel.fetchItems { [weak self] addresses in
            if addresses.count == 0 {
                self?.tableViewHeightConstraint.constant = 0
            }
        }
    }
}

extension FoodAddressView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
