//
//  PaymentsHistoryViewController.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 23.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class PaymentsHistoryViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "HistoryBackground"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var emptyMessageLabel: UILabel = {
        let label = UILabel()
        label.text = StringsHelper.emptyMessage.text()
        label.font = FontHelper.regular26.font()
        label.textAlignment = .center
        label.textColor = ColorHelper.secondaryText.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PaymentTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDataSource
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var dimmerView: DimmerView = {
        let dimmerView = DimmerView()
        dimmerView.alpha = 0
        let tap = UITapGestureRecognizer(target: self, action: #selector(hidePaymentInfo))
        dimmerView.addGestureRecognizer(tap)
        dimmerView.translatesAutoresizingMaskIntoConstraints = false
        return dimmerView
    }()
    
    private lazy var paymentView = PaymentView()
    
    private let emptyMessageBottomMargin: CGFloat = 100
    
    private let service: IPaymentsHistoryService = PaymentsHistoryService()
    
    // MARK: - Private properties
    
    private let cellId = "paymentHistoryCell"
    private lazy var tableViewDataSource = PaymentsHistoryTableViewDataSource(cellId: cellId)
    private lazy var tableViewDelegate =
        PaymentsHistoryTableViewDelegate(viewController: self) { [weak self] indexPath in
            if let model = self?.models[indexPath.row] {
                self?.showPaymentInfo(model: model, indexPath: indexPath)
            }
        }
    private var models: [Payment] = [] {
        didSet {
            tableViewDataSource.setModels(models)
            tableView.reloadData()
            emptyMessageLabel.isHidden = models.count > 0
            backgroundImageView.isHidden = models.count > 0
        }
    }
    
    private var selectedIndexPath: IndexPath?
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = PaymentsHistoryStrings.title.text()
        setupLayout()
        loadData()
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        view.backgroundColor = ColorHelper.secondaryBackground.color()
        view.addSubview(backgroundImageView)
        view.addSubview(emptyMessageLabel)
        
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyMessageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyMessageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyMessageLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -emptyMessageBottomMargin),
        ])
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        view.addSubview(dimmerView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmerView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadData() {
        service.getPayments { [weak self] result in
            switch result {
            case .failure:
                AlertHelper().alert(self, title: StringsHelper.error.text(), message: StringsHelper.tryAgain.text())
            case .success(let payments):
                if payments.count > 0 {
                    DispatchQueue.main.async {
                        self?.setupTableView()
                        self?.models = payments
                    }
                }
            }
        }
    }
    
    private func showPaymentInfo(model: Payment, indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath),
              let paymentModel = PaymentCellModel(payment: model) else {
            return
        }
        selectedIndexPath = indexPath
        paymentView = PaymentView()
        paymentView.configure(with: paymentModel)
        paymentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(paymentView)
        let middleConstraint = paymentView.centerYAnchor.constraint(equalTo: cell.centerYAnchor)
        paymentViewMiddleConstraint = paymentView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        NSLayoutConstraint.activate([
            paymentView.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
            paymentView.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
            middleConstraint
        ])
        
        view.layoutIfNeeded()
        cell.alpha = 0
        
        paymentView.expand { [weak self] in
            guard let self = self else { return }
            self.dimmerView.alpha = 1
            self.paymentView.alpha = 1
            middleConstraint.isActive = false
            self.paymentViewMiddleConstraint?.isActive = true
            self.view.layoutIfNeeded()
        }
    }
    
    private var paymentViewMiddleConstraint: NSLayoutConstraint?
    
    @objc private func hidePaymentInfo() {
        guard let selectedIndexPath = self.selectedIndexPath,
              let cell = tableView.cellForRow(at: selectedIndexPath)
        else { return }
        
        paymentViewMiddleConstraint?.isActive = false
        paymentView.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
        paymentView.shrink(with: { [weak self] in
            self?.dimmerView.alpha = 0
            self?.view.layoutIfNeeded()
            cell.alpha = 1
        }, completion: { [weak self] in
            self?.paymentView.removeFromSuperview()
        })
    }
}
