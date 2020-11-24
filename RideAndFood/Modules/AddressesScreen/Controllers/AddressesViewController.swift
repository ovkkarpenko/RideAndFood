//
//  AddressesViewController.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 09.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import RxSwift
import Foundation

class AddressesViewController: UIViewController {
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorHelper.background.color()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let image = UIImage(named: "background", in: Bundle.init(path: "Images/Addresses"), with: .none)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var alertLabel: UILabel = {
        let label = UILabel()
        label.text = AddressesStrings.alertLabel.text()
        label.font = .systemFont(ofSize: 26)
        label.textColor = ColorHelper.secondaryText.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addAddressButton: UIButton = {
        let button = PrimaryButton(title: AddressesStrings.addAddressButton.text())
        button.addTarget(self, action: #selector(showAddAddresController), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.isHidden = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let padding: CGFloat = 20
    private let cellIdentifier = "AddressCell"
    
    private lazy var backgroundImageYAnchorConstraint = backgroundImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    
    private let bag = DisposeBag()
    private let viewModel = AddressViewModel(type: .addAddress)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = AddressesStrings.title.text()
        navigationItem.backButtonTitle = " "
        navigationController?.navigationBar.tintColor = .gray
        setupLayout()
        setupTableView()
        
        viewModel.fetchItems { [weak self] in
            self?.showAddressesTable()
        }
    }
    
    func setupLayout() {
        view.addSubview(backgroundView)
        view.addSubview(backgroundImage)
        view.addSubview(tableView)
        view.addSubview(alertLabel)
        view.addSubview(addAddressButton)
        
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            backgroundImageYAnchorConstraint,
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding+100),
            tableView.bottomAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: -padding),
            
            alertLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertLabel.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: 30),
            
            addAddressButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            addAddressButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            addAddressButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding-10),
        ])
    }
    
    func setupTableView() {
        tableView.register(AddressTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        tableView
            .rx.setDelegate(self)
            .disposed(by: bag)
        
        tableView.rx
            .modelSelected(Address.self)
            .subscribe(onNext: { [weak self] address in
                let vc = AddAddresViewController()
                vc.address = address
                self?.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: bag)
        
        viewModel.addressesPublishSubject
            .bind(to: tableView.rx.items(dataSource: viewModel.dataSource(cellIdentifier: cellIdentifier)))
            .disposed(by: bag)
    }
    
    func showAddressesTable() {
        if tableView.isHidden {
            
            let image = UIImage(named: "background2", in: Bundle.init(path: "Images/Addresses"), with: .none)
            backgroundImage.image = image
            
            alertLabel.isHidden = true
            tableView.isHidden = false
            backgroundImageYAnchorConstraint.constant = 110
        }
    }
    
    @objc private func showAddAddresController() {
        let vc = AddAddresViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension AddressesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
