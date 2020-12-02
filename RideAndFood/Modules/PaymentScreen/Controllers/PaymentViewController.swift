//
//  PaymentViewController.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 05.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class PaymentViewController: UIViewController {
    
    private let bag = DisposeBag()
    let viewModel = PaymentViewModel()
    
    private lazy var tableView: UITableView = {
        let cellIdentifier = "PaymentCell"
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        viewModel.items
            .bind(to: tableView.rx.items(dataSource: viewModel.dataSource(cellIdentifier: cellIdentifier)))
            .disposed(by: bag)
        
        tableView.rx.modelSelected(TableItem.self)
            .subscribe(onNext: { item in
                item.completion?(self)
            }).disposed(by: bag)
        
        viewModel.fetchItems()
        
        tableView.rx.itemSelected
          .subscribe(onNext: { [weak self] indexPath in
            tableView.deselectRow(at: indexPath, animated: true)
          }).disposed(by: bag)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let image = UIImage(named: "womanBackground", in: Bundle.init(path: "Images/PaymentScreen"), with: .none)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var bindCardButton: PrimaryButton = {
        let button = PrimaryButton(title: PaymentStrings.bindCard.text())
        button.addTarget(self, action: #selector(showBindCardController), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let padding: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = PaymentStrings.paymentTitle.text()
        viewModel.bindCardCallback = { [weak self] in
            let vc = BindCardViewController()
            vc.confirmCallback = {
                self?.viewModel.fetchItems()
            }
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        viewModel.loadedCardsCallback = { [weak self] in
            DispatchQueue.main.async {
                UIView.animate(withDuration: ConstantsHelper.baseAnimationDuration.value(), animations: {
                    self?.backgroundImageView.alpha = 0
                    self?.bindCardButton.alpha = 0
                }, completion: { _ in
                    self?.backgroundImageView.isHidden = true
                    self?.bindCardButton.isHidden = true
                })
            }
        }
        
        setupLayout()
    }
    
    func setupLayout() {
        view.addSubview(tableView)
        view.addSubview(backgroundImageView)
        view.addSubview(bindCardButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bindCardButton.topAnchor, constant: -20),
            backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            bindCardButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            bindCardButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            bindCardButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding)
        ])
    }
    
    @objc private func showBindCardController() {
        let vc = BindCardViewController()
        vc.confirmCallback = { [weak self] in
            self?.viewModel.fetchItems()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
